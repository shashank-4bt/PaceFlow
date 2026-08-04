import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import 'package:paceflow/features/tracking/data/datasources/location_datasource.dart';
import 'package:paceflow/features/tracking/data/datasources/step_counter_datasource.dart';
import 'package:paceflow/features/tracking/data/providers/tracking_providers.dart';
import 'package:paceflow/features/tracking/data/services/background_tracking_service.dart';
import 'package:paceflow/features/tracking/data/services/gps_recovery_service.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_metrics.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';
import 'package:paceflow/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:paceflow/features/tracking/domain/services/gps_filter.dart';
import 'package:paceflow/features/tracking/domain/services/metrics_engine.dart';
final locationDataSourceProvider = Provider<LocationDataSource>((ref) {
  final source = LocationDataSource();
  ref.onDispose(source.dispose);
  return source;
});

final stepCounterDataSourceProvider = Provider<StepCounterDataSource>((ref) {
  final source = StepCounterDataSource();
  ref.onDispose(source.dispose);
  return source;
});

final gpsRecoveryServiceProvider = Provider<GpsRecoveryService>((ref) {
  return GpsRecoveryService(
    repository: ref.watch(trackingRepositoryProvider),
    local: ref.watch(walkLocalDataSourceProvider),
  );
});

class WalkSessionState {
  const WalkSessionState({
    this.session,
    this.isLoading = false,
    this.errorMessage,
    this.unsavedPointCount = 0,
  });

  final WalkSession? session;
  final bool isLoading;
  final String? errorMessage;
  final int unsavedPointCount;

  WalkSessionState copyWith({
    WalkSession? session,
    bool? isLoading,
    String? errorMessage,
    int? unsavedPointCount,
    bool clearSession = false,
    bool clearError = false,
  }) {
    return WalkSessionState(
      session: clearSession ? null : (session ?? this.session),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      unsavedPointCount: unsavedPointCount ?? this.unsavedPointCount,
    );
  }
}

class WalkSessionController extends Notifier<WalkSessionState> {
  static const _persistEveryPoints = 10;
  static const _persistEvery = Duration(seconds: 5);

  final _log = Logger('WalkSessionController');

  StreamSubscription<GeoPoint>? _locationSub;
  StreamSubscription<int>? _stepSub;
  Timer? _durationTimer;
  Timer? _persistTimer;

  late GpsFilter _gpsFilter;
  late MetricsEngine _metricsEngine;

  int _pointsSincePersist = 0;
  DateTime? _lastPersistAt;

  @override
  WalkSessionState build() {
    _gpsFilter = GpsFilter();
    _metricsEngine = MetricsEngine();
    ref.onDispose(_disposeResources);
    unawaited(_recoverIfNeeded());
    return const WalkSessionState();
  }

  TrackingRepository get _repository => ref.read(trackingRepositoryProvider);
  LocationDataSource get _location => ref.read(locationDataSourceProvider);
  StepCounterDataSource get _steps => ref.read(stepCounterDataSourceProvider);

  Future<void> _recoverIfNeeded() async {
    state = state.copyWith(isLoading: true);
    final recovery = await ref.read(gpsRecoveryServiceProvider).recoverOnAppStart();
    if (recovery.session != null) {
      _gpsFilter = recovery.gpsFilter ?? GpsFilter();
      _metricsEngine = recovery.metricsEngine ?? MetricsEngine();
      state = state.copyWith(
        session: recovery.session,
        isLoading: false,
        clearError: true,
      );
      if (recovery.session!.isActive) {
        await _beginTrackingStreams(recovery.session!);
      } else if (recovery.session!.isPaused) {
        _startDurationTimer();
      }
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> startWalk({
    required String userId,
    String? title,
    double weightKg = 70,
  }) async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      await _location.ensurePermissions();

      final session = await ref.read(startWalkUseCaseProvider)(
        userId: userId,
        title: title,
        weightKg: weightKg,
      );

      _gpsFilter.reset();
      _metricsEngine = MetricsEngine(defaultWeightKg: weightKg)..reset();

      final active = session.copyWith(status: WalkSessionStatus.active);
      state = state.copyWith(session: active, isLoading: false);

      await BackgroundTrackingService.instance.start(
        walkId: active.id,
        userId: userId,
      );
      await _beginTrackingStreams(active);
    } catch (error) {
      _log.warning('Failed to start walk', error);
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> pauseWalk() async {
    final session = state.session;
    if (session == null || !session.isActive) return;

    final paused = await ref.read(pauseWalkUseCaseProvider)(session.id);
    await _location.stopTracking();
    _stopDurationTimer();

    state = state.copyWith(
      session: paused.copyWith(
        pausedAt: DateTime.now(),
        points: session.points,
        metrics: _currentMetrics(session),
      ),
    );

    await BackgroundTrackingService.instance.updateNotification(
      distanceMeters: state.session!.metrics.distanceMeters,
      duration: Duration(milliseconds: state.session!.metrics.durationMs),
      isPaused: true,
    );
  }

  Future<void> resumeWalk() async {
    final session = state.session;
    if (session == null || !session.isPaused) return;

    final resumed = await ref.read(resumeWalkUseCaseProvider)(session.id);
    state = state.copyWith(session: resumed.copyWith(points: session.points));
    await _location.startTracking();
    _startDurationTimer();

    await BackgroundTrackingService.instance.updateNotification(
      distanceMeters: state.session!.metrics.distanceMeters,
      duration: Duration(milliseconds: state.session!.metrics.durationMs),
      isPaused: false,
    );
  }

  Future<WalkSession?> stopWalk() async {
    final session = state.session;
    if (session == null) return null;

    state = state.copyWith(isLoading: true);
    await _stopTrackingStreams();

    final metrics = _currentMetrics(
      session.copyWith(status: WalkSessionStatus.stopping),
    );
    final withMetrics = session.copyWith(metrics: metrics, points: session.points);
    await _repository.updateLiveMetrics(withMetrics);

    final completed = await ref.read(stopWalkUseCaseProvider)(session.id);
    await BackgroundTrackingService.instance.stop();

    state = state.copyWith(
      session: completed.copyWith(points: session.points),
      isLoading: false,
      clearError: true,
    );
    return state.session;
  }

  Future<void> discardWalk() async {
    final session = state.session;
    if (session == null) return;

    await _stopTrackingStreams();
    await ref.read(discardWalkUseCaseProvider)(session.id);
    await BackgroundTrackingService.instance.stop();
    state = state.copyWith(clearSession: true);
  }

  Future<void> _beginTrackingStreams(WalkSession session) async {
    await _location.startTracking();
    await _steps.start(initialSteps: session.metrics.steps);
    _startDurationTimer();
    _startPersistTimer();

    await _locationSub?.cancel();
    _locationSub = _location.locationStream.listen(_onLocation);

    await _stepSub?.cancel();
    _stepSub = _steps.stepStream.listen(_onSteps);
  }

  Future<void> _stopTrackingStreams() async {
    await _locationSub?.cancel();
    await _stepSub?.cancel();
    await _location.stopTracking();
    await _steps.stop();
    _stopDurationTimer();
    _stopPersistTimer();
    await _persistNow(force: true);
  }

  void _onLocation(GeoPoint rawPoint) {
    final session = state.session;
    if (session == null || !session.isActive) return;

    final accepted = _gpsFilter.filter(rawPoint);
    final point = accepted ?? rawPoint.copyWith(isFiltered: true);
    final updatedPoints = [...session.points, point];

    if (accepted != null) {
      _metricsEngine.addPoint(accepted);
    }

    final metrics = _currentMetrics(session);
    state = state.copyWith(
      session: session.copyWith(points: updatedPoints, metrics: metrics),
      unsavedPointCount: state.unsavedPointCount + 1,
    );

    _pointsSincePersist++;
    if (_pointsSincePersist >= _persistEveryPoints) {
      unawaited(_persistNow());
    }

    unawaited(
      BackgroundTrackingService.instance.updateNotification(
        distanceMeters: metrics.distanceMeters,
        duration: Duration(milliseconds: metrics.durationMs),
        isPaused: false,
      ),
    );
  }

  void _onSteps(int steps) {
    final session = state.session;
    if (session == null) return;

    final metrics = _currentMetrics(session).copyWith(steps: steps);
    state = state.copyWith(
      session: session.copyWith(metrics: metrics),
    );
  }

  void _startDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final session = state.session;
      if (session == null || session.isPaused) return;
      state = state.copyWith(
        session: session.copyWith(metrics: _currentMetrics(session)),
      );
    });
  }

  void _stopDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = null;
  }

  void _startPersistTimer() {
    _persistTimer?.cancel();
    _persistTimer = Timer.periodic(_persistEvery, (_) {
      unawaited(_persistNow());
    });
  }

  void _stopPersistTimer() {
    _persistTimer?.cancel();
    _persistTimer = null;
  }

  Future<void> _persistNow({bool force = false}) async {
    final session = state.session;
    if (session == null) return;

    final now = DateTime.now();
    if (!force &&
        _lastPersistAt != null &&
        now.difference(_lastPersistAt!) < const Duration(seconds: 4) &&
        _pointsSincePersist == 0) {
      return;
    }

    try {
      final recentPoints = session.points.length > _pointsSincePersist
          ? session.points.sublist(session.points.length - _pointsSincePersist)
          : session.points;

      for (final point in recentPoints) {
        await _repository.appendPoint(session.id, point);
      }

      await _repository.updateLiveMetrics(session);
      if (session.metrics.steps > 0) {
        await _repository.updateSteps(session.id, session.metrics.steps);
      }

      _pointsSincePersist = 0;
      _lastPersistAt = now;
      state = state.copyWith(unsavedPointCount: 0);
    } catch (error) {
      _log.warning('Persist failed', error);
    }
  }

  WalkMetrics _currentMetrics(WalkSession session) {
    final elapsedMs = DateTime.now().difference(session.startedAt).inMilliseconds;
    return _metricsEngine.currentMetrics(
      durationMs: elapsedMs,
      pausedDurationMs: session.metrics.pausedDurationMs,
      steps: session.metrics.steps,
      weightKg: session.weightKg,
    );
  }

  Future<void> _disposeResources() async {
    await _stopTrackingStreams();
  }
}

final walkSessionControllerProvider =
    NotifierProvider<WalkSessionController, WalkSessionState>(
  WalkSessionController.new,
);

final currentUserIdProvider = Provider<String>((ref) {
  return 'local-user';
});
