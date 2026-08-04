import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/features/statistics/domain/services/badge_evaluator.dart';

void main() {
  const catalog = [
    BadgeDefinition(
      id: 'first_walk',
      title: 'First Steps',
      criteriaType: BadgeCriteriaType.totalWalks,
      threshold: 1,
    ),
    BadgeDefinition(
      id: '5k_total',
      title: '5K Club',
      criteriaType: BadgeCriteriaType.totalDistanceMeters,
      threshold: 5000,
    ),
    BadgeDefinition(
      id: 'week_streak',
      title: 'Week Warrior',
      criteriaType: BadgeCriteriaType.currentStreakDays,
      threshold: 7,
    ),
    BadgeDefinition(
      id: 'long_walk',
      title: 'Long Haul',
      criteriaType: BadgeCriteriaType.singleWalkDistanceMeters,
      threshold: 10000,
    ),
  ];

  group('BadgeEvaluator', () {
    const evaluator = BadgeEvaluator();

    test('unlocks first walk badge on first completed walk', () {
      const lifetime = LifetimeStats(totalWalks: 1, totalDistanceMeters: 2400);

      final result = evaluator.evaluate(
        catalog: catalog,
        lifetime: lifetime,
        alreadyUnlocked: {},
        latestWalkDistanceMeters: 2400,
        latestWalkDurationMs: 1800000,
      );

      expect(result.newlyUnlockedBadgeIds, contains('first_walk'));
      expect(result.newlyUnlockedBadgeIds, isNot(contains('5k_total')));
    });

    test('unlocks distance badge when lifetime total crosses threshold', () {
      const lifetime = LifetimeStats(
        totalWalks: 3,
        totalDistanceMeters: 5200,
      );

      final result = evaluator.evaluate(
        catalog: catalog,
        lifetime: lifetime,
        alreadyUnlocked: {'first_walk'},
        latestWalkDistanceMeters: 2000,
      );

      expect(result.newlyUnlockedBadgeIds, contains('5k_total'));
    });

    test('unlocks streak badge at seven days', () {
      const lifetime = LifetimeStats(
        totalWalks: 7,
        currentStreakDays: 7,
      );

      final result = evaluator.evaluate(
        catalog: catalog,
        lifetime: lifetime,
        alreadyUnlocked: {'first_walk'},
      );

      expect(result.newlyUnlockedBadgeIds, contains('week_streak'));
    });

    test('unlocks single-walk distance badge from latest walk only', () {
      const lifetime = LifetimeStats(
        totalWalks: 5,
        totalDistanceMeters: 15000,
      );

      final result = evaluator.evaluate(
        catalog: catalog,
        lifetime: lifetime,
        alreadyUnlocked: {'first_walk', '5k_total'},
        latestWalkDistanceMeters: 10500,
      );

      expect(result.newlyUnlockedBadgeIds, contains('long_walk'));
    });

    test('does not re-unlock already earned badges', () {
      const lifetime = LifetimeStats(
        totalWalks: 10,
        totalDistanceMeters: 20000,
        currentStreakDays: 14,
      );

      final result = evaluator.evaluate(
        catalog: catalog,
        lifetime: lifetime,
        alreadyUnlocked: {'first_walk', '5k_total', 'week_streak', 'long_walk'},
        latestWalkDistanceMeters: 12000,
      );

      expect(result.hasUnlocks, isFalse);
      expect(result.newlyUnlockedBadgeIds, isEmpty);
    });

    test('ignores badges with unknown criteria type', () {
      const unknownBadge = BadgeDefinition(
        id: 'mystery',
        title: 'Mystery',
        criteriaType: BadgeCriteriaType.unknown,
        threshold: 1,
      );

      final result = evaluator.evaluate(
        catalog: [unknownBadge],
        lifetime: const LifetimeStats(totalWalks: 99),
        alreadyUnlocked: {},
      );

      expect(result.newlyUnlockedBadgeIds, isEmpty);
    });

    test('BadgeDefinition.fromMap parses criteria from Firestore shape', () {
      final badge = BadgeDefinition.fromMap('5k_total', {
        'title': '5K Club',
        'criteria': {
          'type': 'total_distance_meters',
          'threshold': 5000,
        },
      });

      expect(badge.criteriaType, BadgeCriteriaType.totalDistanceMeters);
      expect(badge.threshold, 5000);
    });
  });
}
