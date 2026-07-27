import 'package:paceflow/features/statistics/domain/entities/achievement.dart';
import 'package:paceflow/features/statistics/domain/entities/lifetime_stats.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';

class EvaluateAchievements {
  static const _catalog = [
    Achievement(
      id: AchievementId.firstWalk,
      title: 'First Steps',
      description: 'Complete your first walk',
      iconName: 'directions_walk',
    ),
    Achievement(
      id: AchievementId.distance10k,
      title: '10K Club',
      description: 'Walk 10 km total',
      iconName: 'route',
    ),
    Achievement(
      id: AchievementId.distance50k,
      title: 'Half Century',
      description: 'Walk 50 km total',
      iconName: 'hiking',
    ),
    Achievement(
      id: AchievementId.distance100k,
      title: 'Century Walker',
      description: 'Walk 100 km total',
      iconName: 'emoji_events',
    ),
    Achievement(
      id: AchievementId.streak7,
      title: 'Week Warrior',
      description: '7-day walking streak',
      iconName: 'local_fire_department',
    ),
    Achievement(
      id: AchievementId.streak30,
      title: 'Monthly Momentum',
      description: '30-day walking streak',
      iconName: 'whatshot',
    ),
    Achievement(
      id: AchievementId.walks10,
      title: 'Regular Walker',
      description: 'Complete 10 walks',
      iconName: 'repeat',
    ),
    Achievement(
      id: AchievementId.walks50,
      title: 'Dedicated',
      description: 'Complete 50 walks',
      iconName: 'star',
    ),
    Achievement(
      id: AchievementId.calorie1000,
      title: 'Calorie Crusher',
      description: 'Burn 1,000 calories total',
      iconName: 'local_fire_department',
    ),
  ];

  List<Achievement> call({
    required LifetimeStats lifetime,
    required List<WalkDto> walks,
    Map<String, DateTime>? savedUnlockDates,
  }) {
    final completed = walks.where((w) => w.status == 'completed').toList()
      ..sort((a, b) => a.startedAt.compareTo(b.startedAt));

    final firstWalkDate = completed.isNotEmpty ? completed.first.startedAt : null;

    return _catalog.map((achievement) {
      final saved = savedUnlockDates?[achievement.id.key];
      final unlockedAt = saved ?? _evaluateUnlock(
            achievement.id,
            lifetime: lifetime,
            firstWalkDate: firstWalkDate,
          );
      return achievement.copyWith(unlockedAt: unlockedAt);
    }).toList();
  }

  DateTime? _evaluateUnlock(
    AchievementId id, {
    required LifetimeStats lifetime,
    DateTime? firstWalkDate,
  }) {
    switch (id) {
      case AchievementId.firstWalk:
        return lifetime.totalWalks >= 1 ? firstWalkDate : null;
      case AchievementId.distance10k:
        return lifetime.totalDistanceMeters >= 10000 ? DateTime.now() : null;
      case AchievementId.distance50k:
        return lifetime.totalDistanceMeters >= 50000 ? DateTime.now() : null;
      case AchievementId.distance100k:
        return lifetime.totalDistanceMeters >= 100000 ? DateTime.now() : null;
      case AchievementId.streak7:
        return lifetime.currentStreakDays >= 7 ||
                lifetime.longestStreakDays >= 7
            ? DateTime.now()
            : null;
      case AchievementId.streak30:
        return lifetime.currentStreakDays >= 30 ||
                lifetime.longestStreakDays >= 30
            ? DateTime.now()
            : null;
      case AchievementId.walks10:
        return lifetime.totalWalks >= 10 ? DateTime.now() : null;
      case AchievementId.walks50:
        return lifetime.totalWalks >= 50 ? DateTime.now() : null;
      case AchievementId.calorie1000:
        return lifetime.totalCaloriesKcal >= 1000 ? DateTime.now() : null;
    }
  }
}
