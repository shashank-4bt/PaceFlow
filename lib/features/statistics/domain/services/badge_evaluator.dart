import 'package:equatable/equatable.dart';

/// Lifetime aggregate stats used for badge evaluation.
class LifetimeStats extends Equatable {
  const LifetimeStats({
    this.totalDistanceMeters = 0,
    this.totalWalks = 0,
    this.totalDurationMs = 0,
    this.currentStreakDays = 0,
    this.longestStreakDays = 0,
  });

  final double totalDistanceMeters;
  final int totalWalks;
  final int totalDurationMs;
  final int currentStreakDays;
  final int longestStreakDays;

  @override
  List<Object?> get props => [
        totalDistanceMeters,
        totalWalks,
        totalDurationMs,
        currentStreakDays,
        longestStreakDays,
      ];
}

/// Badge definition from `badgeCatalog/{badgeId}`.
class BadgeDefinition extends Equatable {
  const BadgeDefinition({
    required this.id,
    required this.title,
    required this.criteriaType,
    required this.threshold,
  });

  final String id;
  final String title;
  final BadgeCriteriaType criteriaType;
  final double threshold;

  factory BadgeDefinition.fromMap(String id, Map<String, dynamic> map) {
    final criteria = map['criteria'] as Map<String, dynamic>? ?? const {};
    return BadgeDefinition(
      id: id,
      title: map['title'] as String? ?? id,
      criteriaType: BadgeCriteriaType.fromString(
        criteria['type'] as String? ?? '',
      ),
      threshold: (criteria['threshold'] as num?)?.toDouble() ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, title, criteriaType, threshold];
}

enum BadgeCriteriaType {
  totalDistanceMeters,
  totalWalks,
  currentStreakDays,
  longestStreakDays,
  singleWalkDistanceMeters,
  singleWalkDurationMs,
  unknown;

  static BadgeCriteriaType fromString(String value) {
    return switch (value) {
      'total_distance_meters' => BadgeCriteriaType.totalDistanceMeters,
      'total_walks' => BadgeCriteriaType.totalWalks,
      'current_streak_days' => BadgeCriteriaType.currentStreakDays,
      'longest_streak_days' => BadgeCriteriaType.longestStreakDays,
      'single_walk_distance_meters' =>
        BadgeCriteriaType.singleWalkDistanceMeters,
      'single_walk_duration_ms' => BadgeCriteriaType.singleWalkDurationMs,
      _ => BadgeCriteriaType.unknown,
    };
  }
}

/// Result of evaluating badges after a completed walk.
class BadgeUnlockResult extends Equatable {
  const BadgeUnlockResult({
    required this.newlyUnlockedBadgeIds,
  });

  final List<String> newlyUnlockedBadgeIds;

  bool get hasUnlocks => newlyUnlockedBadgeIds.isNotEmpty;

  @override
  List<Object?> get props => [newlyUnlockedBadgeIds];
}

/// Evaluates badge criteria against lifetime stats and the latest walk.
class BadgeEvaluator {
  const BadgeEvaluator();

  BadgeUnlockResult evaluate({
    required Iterable<BadgeDefinition> catalog,
    required LifetimeStats lifetime,
    required Set<String> alreadyUnlocked,
    double? latestWalkDistanceMeters,
    int? latestWalkDurationMs,
  }) {
    final unlocked = <String>[];

    for (final badge in catalog) {
      if (alreadyUnlocked.contains(badge.id)) {
        continue;
      }
      if (_isMet(
        badge: badge,
        lifetime: lifetime,
        latestWalkDistanceMeters: latestWalkDistanceMeters,
        latestWalkDurationMs: latestWalkDurationMs,
      )) {
        unlocked.add(badge.id);
      }
    }

    return BadgeUnlockResult(newlyUnlockedBadgeIds: unlocked);
  }

  bool _isMet({
    required BadgeDefinition badge,
    required LifetimeStats lifetime,
    required double? latestWalkDistanceMeters,
    required int? latestWalkDurationMs,
  }) {
    return switch (badge.criteriaType) {
      BadgeCriteriaType.totalDistanceMeters =>
        lifetime.totalDistanceMeters >= badge.threshold,
      BadgeCriteriaType.totalWalks =>
        lifetime.totalWalks >= badge.threshold,
      BadgeCriteriaType.currentStreakDays =>
        lifetime.currentStreakDays >= badge.threshold,
      BadgeCriteriaType.longestStreakDays =>
        lifetime.longestStreakDays >= badge.threshold,
      BadgeCriteriaType.singleWalkDistanceMeters =>
        (latestWalkDistanceMeters ?? 0) >= badge.threshold,
      BadgeCriteriaType.singleWalkDurationMs =>
        (latestWalkDurationMs ?? 0) >= badge.threshold,
      BadgeCriteriaType.unknown => false,
    };
  }
}
