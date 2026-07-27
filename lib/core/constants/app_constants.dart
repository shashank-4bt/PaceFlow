/// Global application constants for PaceFlow.
abstract final class AppConstants {
  static const String appName = 'PaceFlow';
  static const String tagline = 'Every Step Has a Story.';
  static const String packageName = 'com.paceflow.paceflow';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;

  // ── GPS & tracking ────────────────────────────────────────────────────────
  /// Minimum acceptable horizontal accuracy in meters (outdoor target p95 < 15m).
  static const double gpsMinAccuracyMeters = 15.0;

  /// Maximum plausible walking speed in m/s (~18 km/h upper bound for filter).
  static const double gpsMaxSpeedMps = 5.0;

  /// Minimum distance between accepted GPS points in meters.
  static const double gpsMinDistanceMeters = 2.0;

  /// Reject point if jump exceeds this distance in meters within one interval.
  static const double gpsMaxJumpDistanceMeters = 50.0;

  /// Active tracking location update interval (ms). Target 1–3s per PRD.
  static const int gpsActiveIntervalMs = 2000;

  /// Paused tracking location update interval (ms).
  static const int gpsPausedIntervalMs = 10000;

  /// Distance filter in meters for geolocator when actively tracking.
  static const int gpsDistanceFilterMeters = 3;

  /// Seconds without a fix before triggering GPS recovery flow.
  static const int gpsRecoveryTimeoutSeconds = 30;

  /// Local persistence flush interval during an active walk (ms).
  static const int walkLocalPersistIntervalMs = 5000;

  /// Number of GPS points buffered before a local Drift flush.
  static const int walkLocalPersistPointBatch = 25;

  // ── Calorie MET table (walking, pace in min/km) ───────────────────────────
  /// MET values keyed by upper bound of pace range (min/km).
  /// Formula: kcal = MET × weightKg × durationHours.
  static final Map<double, double> calorieMetByPaceMinPerKm = {
    10.0: 5.0,
    12.0: 4.3,
    16.0: 3.5,
    double.infinity: 2.8,
  };

  static const double defaultWeightKg = 70.0;
  static const double defaultMetWalking = 3.5;

  /// Returns MET for a given pace in seconds per kilometer.
  static double metForPaceSecPerKm(double paceSecPerKm) {
    if (paceSecPerKm <= 0) {
      return defaultMetWalking;
    }
    final paceMinPerKm = paceSecPerKm / 60.0;
    for (final entry in calorieMetByPaceMinPerKm.entries) {
      if (paceMinPerKm < entry.key) {
        return entry.value;
      }
    }
    return 2.8;
  }

  /// Computes calories burned.
  static double caloriesKcal({
    required double weightKg,
    required double durationMs,
    required double paceSecPerKm,
  }) {
    if (durationMs <= 0 || weightKg <= 0) {
      return 0;
    }
    final met = metForPaceSecPerKm(paceSecPerKm);
    final hours = durationMs / Duration.millisecondsPerHour;
    return met * weightKg * hours;
  }

  // ── Sync batch sizes ──────────────────────────────────────────────────────
  /// Firestore point chunk size per subcollection document.
  static const int syncPointChunkSize = 500;

  /// Maximum walks uploaded in a single sync pass.
  static const int syncWalkBatchSize = 10;

  /// Maximum pending operations processed per connectivity restore.
  static const int syncOperationBatchSize = 25;

  /// Retry backoff base delay (ms) for failed sync operations.
  static const int syncRetryBaseDelayMs = 2000;

  /// Maximum sync retry attempts before marking as failed.
  static const int syncMaxRetryAttempts = 5;

  // ── Share export dimensions ───────────────────────────────────────────────
  static const int shareStoryWidth = 1080;
  static const int shareStoryHeight = 1920;

  static const int shareSquareWidth = 1080;
  static const int shareSquareHeight = 1080;

  static const int shareWallpaperWidth = 1440;
  static const int shareWallpaperHeight = 2560;

  // ── Validation limits ─────────────────────────────────────────────────────
  static const int displayNameMinLength = 2;
  static const int displayNameMaxLength = 50;
  static const int bioMaxLength = 280;
  static const int passwordMinLength = 8;
  static const int passwordMaxLength = 128;

  // ── Units ─────────────────────────────────────────────────────────────────
  static const String unitsKm = 'km';
  static const String unitsMi = 'mi';

  static const double metersPerMile = 1609.344;
  static const double kmPerMile = 1.609344;
}
