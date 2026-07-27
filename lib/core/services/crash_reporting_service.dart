import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../logging/app_logger.dart';

/// Firebase Crashlytics wrapper for fatal and non-fatal error reporting.
class CrashReportingService {
  CrashReportingService({FirebaseCrashlytics? crashlytics})
      : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  final FirebaseCrashlytics _crashlytics;
  final AppLogger _logger = AppLogger('CrashReportingService');

  Future<void> initialize() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
    FlutterError.onError = _crashlytics.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };
  }

  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    try {
      await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
    } catch (error, stackTrace) {
      _logger.warning(
        'Failed to set crashlytics collection',
        error,
        stackTrace,
      );
    }
  }

  Future<void> setUserId(String userId) async {
    try {
      await _crashlytics.setUserIdentifier(userId);
    } catch (error, stackTrace) {
      _logger.warning('Failed to set crashlytics user id', error, stackTrace);
    }
  }

  Future<void> log(String message) async {
    try {
      await _crashlytics.log(message);
    } catch (error, stackTrace) {
      _logger.warning('Failed to log to crashlytics', error, stackTrace);
    }
  }

  Future<void> setCustomKey(String key, Object value) async {
    try {
      await _crashlytics.setCustomKey(key, value);
    } catch (error, stackTrace) {
      _logger.warning('Failed to set crashlytics key', error, stackTrace);
    }
  }

  Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool fatal = false,
    String? reason,
  }) async {
    try {
      await _crashlytics.recordError(
        error,
        stackTrace,
        fatal: fatal,
        reason: reason,
      );
    } catch (recordError, recordStack) {
      _logger.error(
        'Failed to record crashlytics error',
        recordError,
        recordStack,
      );
    }
  }

  Future<void> recordGpsFailure(Object error, StackTrace stackTrace) async {
    await recordError(
      error,
      stackTrace,
      fatal: false,
      reason: 'gps_failure',
    );
  }

  Future<void> recordSyncFailure(Object error, StackTrace stackTrace) async {
    await recordError(
      error,
      stackTrace,
      fatal: false,
      reason: 'sync_failure',
    );
  }
}
