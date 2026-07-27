import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paceflow/features/notifications/data/notification_service.dart';

class NotificationScheduler {
  NotificationScheduler(this._service);

  final NotificationService _service;

  Future<void> scheduleDailyReminder({
    required bool enabled,
    required int hour,
    required int minute,
  }) {
    return _service.scheduleDailyReminder(
      enabled: enabled,
      hour: hour,
      minute: minute,
    );
  }

  Future<void> cancelAll() => _service.cancelAll();
}

final notificationSchedulerProvider = Provider<NotificationScheduler>((ref) {
  return NotificationScheduler(ref.watch(notificationServiceProvider));
});
