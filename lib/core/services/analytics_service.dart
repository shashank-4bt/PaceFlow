import 'package:firebase_analytics/firebase_analytics.dart';

import '../logging/app_logger.dart';

/// Firebase Analytics wrapper with typed event helpers.
class AnalyticsService {
  AnalyticsService({FirebaseAnalytics? analytics})
      : _analytics = analytics ?? FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;
  final AppLogger _logger = AppLogger('AnalyticsService');

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    try {
      await _analytics.setAnalyticsCollectionEnabled(enabled);
    } catch (error, stackTrace) {
      _logger.warning(
        'Failed to set analytics collection',
        error,
        stackTrace,
      );
    }
  }

  Future<void> setUserId(String? userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (error, stackTrace) {
      _logger.warning('Failed to set analytics user id', error, stackTrace);
    }
  }

  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (error, stackTrace) {
      _logger.warning('Failed to set user property: $name', error, stackTrace);
    }
  }

  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
    } catch (error, stackTrace) {
      _logger.warning('Failed to log screen view', error, stackTrace);
    }
  }

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
    } catch (error, stackTrace) {
      _logger.warning('Failed to log event: $name', error, stackTrace);
    }
  }

  Future<void> logSignUp({required String method}) async {
    await logEvent(
      name: 'sign_up',
      parameters: {'method': method},
    );
  }

  Future<void> logLogin({required String method}) async {
    await logEvent(
      name: 'login',
      parameters: {'method': method},
    );
  }

  Future<void> logWalkStarted() async {
    await logEvent(name: 'walk_started');
  }

  Future<void> logWalkCompleted({
    required double distanceMeters,
    required int durationMs,
  }) async {
    await logEvent(
      name: 'walk_completed',
      parameters: {
        'distance_meters': distanceMeters,
        'duration_ms': durationMs,
      },
    );
  }

  Future<void> logShareExported({required String format}) async {
    await logEvent(
      name: 'share_exported',
      parameters: {'format': format},
    );
  }
}
