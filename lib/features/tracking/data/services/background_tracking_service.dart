import 'dart:async';
import 'dart:io';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';

import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/services/gps_filter.dart';
import 'package:paceflow/features/tracking/data/datasources/walk_local_datasource.dart';
import 'package:paceflow/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Callback dispatcher entry point required by flutter_foreground_task.
@pragma('vm:entry-point')
void paceflowTrackingStartCallback() {
  FlutterForegroundTask.setTaskHandler(WalkTrackingTaskHandler());
}

class BackgroundTrackingService {
  BackgroundTrackingService._();

  static final BackgroundTrackingService instance =
      BackgroundTrackingService._();

  static const _notificationChannelId = 'paceflow_tracking';
  static const _notificationChannelName = 'Walk Tracking';

  final _log = Logger('BackgroundTrackingService');
  StreamSubscription<Object>? _dataSubscription;

  Future<void> initialize() async {
    FlutterForegroundTask.initCommunicationPort();
    FlutterForegroundTask.addTaskDataCallback(_onTaskData);
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: _notificationChannelId,
        channelName: _notificationChannelName,
        channelDescription: 'Shows live walk distance and duration.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<bool> start({
    required String walkId,
    required String userId,
  }) async {
    if (await FlutterForegroundTask.isRunningService) {
      await stop();
    }

    WalkTrackingBridge.configure(walkId: walkId, userId: userId);

    if (!await _requestPermissions()) {
      _log.warning('Foreground service permissions not granted');
      return false;
    }

    await FlutterForegroundTask.startService(
      serviceId: 1001,
      serviceTypes: const [ForegroundServiceTypes.location],
      notificationTitle: 'PaceFlow walk in progress',
      notificationText: 'Tracking your route…',
      notificationIcon: null,
      notificationButtons: const [
        NotificationButton(id: 'pause', text: 'Pause'),
        NotificationButton(id: 'stop', text: 'Stop'),
      ],
      callback: paceflowTrackingStartCallback,
    );

    return await FlutterForegroundTask.isRunningService;
  }

  Future<bool> stop() async {
    WalkTrackingBridge.clear();
    await FlutterForegroundTask.stopService();
    return !(await FlutterForegroundTask.isRunningService);
  }

  Future<void> updateNotification({
    required double distanceMeters,
    required Duration duration,
    required bool isPaused,
  }) async {
    if (!await FlutterForegroundTask.isRunningService) return;

    final distanceKm = distanceMeters / 1000;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours.toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    await FlutterForegroundTask.updateService(
      notificationTitle: isPaused ? 'Walk paused' : 'Walk in progress',
      notificationText:
          '${distanceKm.toStringAsFixed(2)} km · $hours:$minutes:$seconds',
    );
  }

  Future<bool> _requestPermissions() async {
    if (!Platform.isAndroid) return true;

    final notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }

    return true;
  }

  void _onTaskData(Object data) {
    if (data is Map) {
      FlutterForegroundTask.sendDataToMain(data);
    }
  }

  Future<void> dispose() async {
    await _dataSubscription?.cancel();
    FlutterForegroundTask.removeTaskDataCallback(_onTaskData);
  }
}

/// Static bridge used by the foreground task isolate to persist GPS points.
class WalkTrackingBridge {
  static String? walkId;
  static String? userId;
  static WalkLocalDataSource? _local;
  static final GpsFilter _filter = GpsFilter();

  static void configure({required String walkId, required String userId}) {
    WalkTrackingBridge.walkId = walkId;
    WalkTrackingBridge.userId = userId;
    _filter.reset();
  }

  static void clear() {
    walkId = null;
    userId = null;
    _local = null;
    _filter.reset();
  }

  static Future<WalkLocalDataSource> localDataSource() async {
    if (_local != null) return _local!;
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'paceflow.db'));
    final db = AppDatabase(NativeDatabase(file));
    _local = WalkLocalDataSource(db);
    return _local!;
  }

  static Future<void> persistPoint(GeoPoint rawPoint) async {
    final activeWalkId = walkId;
    if (activeWalkId == null) return;

    final accepted = _filter.filter(rawPoint);
    final local = await localDataSource();
    await local.appendPoint(
      activeWalkId,
      accepted ?? rawPoint.copyWith(isFiltered: true),
    );

    if (accepted != null) {
      FlutterForegroundTask.sendDataToMain({
        'type': 'location',
        'walkId': activeWalkId,
        'lat': accepted.latitude,
        'lng': accepted.longitude,
        'recordedAt': accepted.recordedAt.millisecondsSinceEpoch,
      });
    }
  }
}

class WalkTrackingTaskHandler extends TaskHandler {
  StreamSubscription<Position>? _locationSubscription;
  final _log = Logger('WalkTrackingTaskHandler');

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _locationSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 3,
      ),
    ).listen(
      (position) {
        unawaited(
          WalkTrackingBridge.persistPoint(
            GeoPoint(
              latitude: position.latitude,
              longitude: position.longitude,
              recordedAt: position.timestamp,
              altitude: position.altitude,
              accuracy: position.accuracy,
              speed: position.speed >= 0 ? position.speed : null,
              bearing: position.heading >= 0 ? position.heading : null,
            ),
          ),
        );
      },
      onError: (Object error) {
        _log.warning('Background location error', error);
      },
    );
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    FlutterForegroundTask.updateService(
      notificationText: 'Tracking · ${timestamp.toLocal().hour}:${timestamp.minute.toString().padLeft(2, '0')}',
    );
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
    WalkTrackingBridge.clear();
  }

  @override
  void onReceiveData(Object data) {}

  @override
  void onNotificationButtonPressed(String id) {
    FlutterForegroundTask.sendDataToMain({'type': 'notification_action', 'id': id});
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp('/');
  }

  @override
  void onNotificationDismissed() {}
}

/// Android manifest helpers for MainActivity integration.
class AndroidForegroundConfig {
  static const permissions = [
    'android.permission.ACCESS_FINE_LOCATION',
    'android.permission.ACCESS_COARSE_LOCATION',
    'android.permission.ACCESS_BACKGROUND_LOCATION',
    'android.permission.FOREGROUND_SERVICE',
    'android.permission.FOREGROUND_SERVICE_LOCATION',
    'android.permission.ACTIVITY_RECOGNITION',
    'android.permission.POST_NOTIFICATIONS',
    'android.permission.WAKE_LOCK',
  ];

  static const manifestServiceSnippet = '''
<service
    android:name="com.pravera.flutter_foreground_task.service.ForegroundService"
    android:foregroundServiceType="location"
    android:exported="false" />
''';
}
