import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:paceflow/core/di/providers.dart';
import 'package:paceflow/core/logging/app_logger.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';

class NotificationService {
  NotificationService({
    FlutterLocalNotificationsPlugin? localNotifications,
    FirebaseMessaging? messaging,
    FirebaseFirestore? firestore,
  })  : _local = localNotifications ?? FlutterLocalNotificationsPlugin(),
        _messaging = messaging ?? FirebaseMessaging.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FlutterLocalNotificationsPlugin _local;
  final FirebaseMessaging _messaging;
  final FirebaseFirestore _firestore;
  final AppLogger _log = AppLogger('NotificationService');

  static const _dailyReminderId = 1001;
  static const _channelId = 'paceflow_reminders';
  static const _channelName = 'Walk Reminders';

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    } catch (_) {
      tz.setLocalLocation(tz.local);
    }

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _local.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    if (Platform.isAndroid) {
      await _local
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              _channelId,
              _channelName,
              description: 'Daily walk reminders and milestones',
              importance: Importance.defaultImportance,
            ),
          );
    }

    await _requestPermissions();
    await _setupFcm();
    _initialized = true;
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _local
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
    await _messaging.requestPermission(alert: true, badge: true, sound: true);
  }

  Future<void> _setupFcm() async {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpened);

    final token = await _messaging.getToken();
    if (token != null) {
      await saveFcmToken(token);
    }
    _messaging.onTokenRefresh.listen(saveFcmToken);
  }

  Future<void> saveFcmToken(String token, {String? userId}) async {
    if (userId == null || userId.isEmpty) return;

    try {
      await _firestore.collection('users').doc(userId).set(
        {'fcmToken': token, 'fcmUpdatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true),
      );
    } catch (error, stack) {
      _log.warning('Failed to save FCM token', error, stack);
    }
  }

  void bindUser(String? userId) {
    _messaging.getToken().then((token) {
      if (token != null && userId != null) {
        saveFcmToken(token, userId: userId);
      }
    });
  }

  void _handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _local.show(
      message.hashCode,
      notification.title ?? 'PaceFlow',
      notification.body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  void _handleMessageOpened(RemoteMessage message) {
    _log.info('Notification opened: ${message.messageId}');
  }

  void _onNotificationTap(NotificationResponse response) {
    _log.info('Local notification tapped: ${response.payload}');
  }

  Future<void> scheduleDailyReminder({
    required bool enabled,
    required int hour,
    required int minute,
  }) async {
    if (!enabled) {
      await _local.cancel(_dailyReminderId);
      return;
    }

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _local.zonedSchedule(
      _dailyReminderId,
      'Time to walk',
      'Every Step Has a Story. Start your walk today!',
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAll() => _local.cancelAll();

  Future<void> showMilestone({
    required String title,
    required String body,
  }) async {
    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final service = NotificationService(firestore: ref.watch(firebaseFirestoreProvider));
  ref.listen(authControllerProvider, (prev, next) {
    service.bindUser(next.user?.uid);
  });
  return service;
});

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    debugPrint('FCM background: ${message.messageId}');
  }
}
