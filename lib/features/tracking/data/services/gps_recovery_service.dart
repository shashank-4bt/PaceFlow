import 'package:logging/logging.dart';

import 'package:paceflow/features/tracking/data/datasources/walk_local_datasource.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';
import 'package:paceflow/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:paceflow/features/tracking/domain/services/gps_filter.dart';
import 'package:paceflow/features/tracking/domain/services/metrics_engine.dart';

class GpsRecoveryResult {
  const GpsRecoveryResult({
    this.session,
    this.gpsFilter,
    this.metricsEngine,
  });

  final WalkSession? session;
  final GpsFilter? gpsFilter;
  final MetricsEngine? metricsEngine;
}

class GpsRecoveryService {
  GpsRecoveryService({
    required TrackingRepository repository,
    required WalkLocalDataSource local,
  })  : _repository = repository,
        _local = local;

  final TrackingRepository _repository;
  final WalkLocalDataSource _local;
  final _log = Logger('GpsRecoveryService');

  Future<GpsRecoveryResult> recoverOnAppStart() async {
    try {
      final session = await _repository.recoverWalk();
      if (session == null) {
        return const GpsRecoveryResult();
      }

      final weightKg = await _local.getUserWeightKg();
      final acceptedPoints =
          session.points.where((point) => !point.isFiltered).toList();

      final filter = GpsFilter();
      final engine = MetricsEngine(defaultWeightKg: weightKg)
        ..restoreFromPoints(acceptedPoints);

      final now = DateTime.now();
      final elapsedMs = now.difference(session.startedAt).inMilliseconds;
      final metrics = engine.currentMetrics(
        durationMs: elapsedMs,
        pausedDurationMs: session.metrics.pausedDurationMs,
        steps: session.metrics.steps,
        weightKg: weightKg,
      );

      final restored = session.copyWith(metrics: metrics, weightKg: weightKg);
      _log.info('Recovered walk ${restored.id} with ${acceptedPoints.length} points');

      return GpsRecoveryResult(
        session: restored,
        gpsFilter: filter,
        metricsEngine: engine,
      );
    } catch (error, stackTrace) {
      _log.severe('Failed to recover walk', error, stackTrace);
      return const GpsRecoveryResult();
    }
  }
}
