/// Keys for [SharedPreferences], [FlutterSecureStorage], and local caches.
abstract final class StorageKeys {
  // Secure storage (sensitive)
  static const String authRefreshToken = 'auth_refresh_token';
  static const String authIdToken = 'auth_id_token';
  static const String deviceId = 'device_id';
  static const String encryptionSalt = 'encryption_salt';

  // Shared preferences (non-sensitive)
  static const String onboardingCompleted = 'onboarding_completed';
  static const String themeMode = 'theme_mode';
  static const String units = 'units';
  static const String localeCode = 'locale_code';
  static const String lastSyncAt = 'last_sync_at';
  static const String lastKnownUserId = 'last_known_user_id';
  static const String dailyReminderEnabled = 'daily_reminder_enabled';
  static const String dailyReminderHour = 'daily_reminder_hour';
  static const String dailyReminderMinute = 'daily_reminder_minute';
  static const String weeklySummaryEnabled = 'weekly_summary_enabled';
  static const String goalNotificationsEnabled = 'goal_notifications_enabled';
  static const String milestoneNotificationsEnabled =
      'milestone_notifications_enabled';
  static const String shareStatsPublicly = 'share_stats_publicly';
  static const String storePreciseLocation = 'store_precise_location';
  static const String analyticsEnabled = 'analytics_enabled';
  static const String crashReportingEnabled = 'crash_reporting_enabled';

  // Active walk recovery
  static const String activeWalkSessionId = 'active_walk_session_id';
  static const String activeWalkStartedAt = 'active_walk_started_at';
  static const String activeWalkRecoveryPayload = 'active_walk_recovery_payload';

  // Cache
  static const String cachedUserProfile = 'cached_user_profile';
  static const String mapStyleDark = 'map_style_dark';
  static const String mapStyleLight = 'map_style_light';
}
