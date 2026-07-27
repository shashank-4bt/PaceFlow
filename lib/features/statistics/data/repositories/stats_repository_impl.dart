import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paceflow/core/di/providers.dart';
import 'package:paceflow/features/statistics/domain/entities/achievement.dart';
import 'package:paceflow/features/statistics/domain/entities/lifetime_stats.dart';
import 'package:paceflow/features/statistics/domain/entities/period_stats.dart';
import 'package:paceflow/features/statistics/domain/entities/personal_record.dart';
import 'package:paceflow/features/statistics/domain/repositories/stats_repository.dart';
import 'package:paceflow/features/statistics/domain/usecases/compute_period_stats.dart';
import 'package:paceflow/features/statistics/domain/usecases/evaluate_achievements.dart';
import 'package:paceflow/features/tracking/data/datasources/walk_local_datasource.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';
import 'package:paceflow/features/tracking/data/providers/tracking_providers.dart';

class StatsRepositoryImpl implements StatsRepository {
  StatsRepositoryImpl({
    required WalkLocalDataSource local,
    required FirebaseFirestore firestore,
    ComputePeriodStats? computePeriodStats,
    EvaluateAchievements? evaluateAchievements,
  })  : _local = local,
        _firestore = firestore,
        _computePeriodStats = computePeriodStats ?? ComputePeriodStats(),
        _evaluateAchievements = evaluateAchievements ?? EvaluateAchievements();

  final WalkLocalDataSource _local;
  final FirebaseFirestore _firestore;
  final ComputePeriodStats _computePeriodStats;
  final EvaluateAchievements _evaluateAchievements;

  @override
  Future<List<WalkDto>> getCompletedWalks(String userId) async {
    final walks = await _local.getWalksByUser(userId);
    return walks.where((w) => w.status == 'completed').toList();
  }

  @override
  Future<LifetimeStats> getLifetimeStats(String userId) async {
    final walks = await getCompletedWalks(userId);
    var totalDistance = 0.0;
    var totalDuration = 0;
    var totalCalories = 0.0;
    var totalSteps = 0;

    for (final walk in walks) {
      totalDistance += walk.distanceMeters;
      totalDuration += walk.durationMs;
      totalCalories += walk.caloriesKcal;
      totalSteps += walk.steps;
    }

    final streaks = _computeStreaks(walks);

    final remoteDoc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('stats')
        .doc('lifetime')
        .get();

    if (remoteDoc.exists) {
      final data = remoteDoc.data()!;
      return LifetimeStats(
        totalDistanceMeters: (data['totalDistanceMeters'] as num?)?.toDouble() ??
            totalDistance,
        totalWalks: (data['totalWalks'] as num?)?.toInt() ?? walks.length,
        totalDurationMs:
            (data['totalDurationMs'] as num?)?.toInt() ?? totalDuration,
        totalCaloriesKcal:
            (data['totalCaloriesKcal'] as num?)?.toDouble() ?? totalCalories,
        totalSteps: (data['totalSteps'] as num?)?.toInt() ?? totalSteps,
        currentStreakDays: streaks.$1,
        longestStreakDays: streaks.$2,
      );
    }

    return LifetimeStats(
      totalDistanceMeters: totalDistance,
      totalWalks: walks.length,
      totalDurationMs: totalDuration,
      totalCaloriesKcal: totalCalories,
      totalSteps: totalSteps,
      currentStreakDays: streaks.$1,
      longestStreakDays: streaks.$2,
    );
  }

  (int current, int longest) _computeStreaks(List<WalkDto> walks) {
    if (walks.isEmpty) return (0, 0);

    final days = walks
        .map(
          (w) => DateTime(
            w.startedAt.year,
            w.startedAt.month,
            w.startedAt.day,
          ),
        )
        .toSet()
        .toList()
      ..sort();

    var longest = 1;
    var current = 1;
    var run = 1;

    for (var i = 1; i < days.length; i++) {
      final diff = days[i].difference(days[i - 1]).inDays;
      if (diff == 1) {
        run++;
        longest = run > longest ? run : longest;
      } else if (diff > 1) {
        run = 1;
      }
    }

    final today = DateTime.now();
    final todayDay = DateTime(today.year, today.month, today.day);
    final lastDay = days.last;
    if (lastDay == todayDay || lastDay == todayDay.subtract(const Duration(days: 1))) {
      run = 1;
      for (var i = days.length - 2; i >= 0; i--) {
        if (days[i + 1].difference(days[i]).inDays == 1) {
          run++;
        } else {
          break;
        }
      }
      current = run;
    } else {
      current = 0;
    }

    return (current, longest);
  }

  @override
  Future<PeriodStats> getPeriodStats(
    String userId, {
    required DateTime start,
    required DateTime end,
  }) async {
    final walks = await getCompletedWalks(userId);
    return _computePeriodStats.call(start: start, end: end, walks: walks);
  }

  @override
  Future<List<PersonalRecord>> getPersonalRecords(String userId) async {
    final walks = await getCompletedWalks(userId);
    if (walks.isEmpty) return [];

    WalkDto? longestDistance;
    WalkDto? longestDuration;
    WalkDto? fastestPace;
    WalkDto? mostCalories;
    WalkDto? mostSteps;

    for (final walk in walks) {
      if (longestDistance == null ||
          walk.distanceMeters > longestDistance.distanceMeters) {
        longestDistance = walk;
      }
      if (longestDuration == null ||
          walk.durationMs > longestDuration.durationMs) {
        longestDuration = walk;
      }
      if (walk.avgPaceSecPerKm > 0 &&
          (fastestPace == null ||
              walk.avgPaceSecPerKm < fastestPace.avgPaceSecPerKm)) {
        fastestPace = walk;
      }
      if (mostCalories == null ||
          walk.caloriesKcal > mostCalories.caloriesKcal) {
        mostCalories = walk;
      }
      if (mostSteps == null || walk.steps > mostSteps.steps) {
        mostSteps = walk;
      }
    }

    final records = <PersonalRecord>[];
    if (longestDistance != null) {
      records.add(
        PersonalRecord(
          type: PersonalRecordType.longestDistance,
          value: longestDistance.distanceMeters,
          walkId: longestDistance.id,
          achievedAt: longestDistance.startedAt,
        ),
      );
    }
    if (longestDuration != null) {
      records.add(
        PersonalRecord(
          type: PersonalRecordType.longestDuration,
          value: longestDuration.durationMs.toDouble(),
          walkId: longestDuration.id,
          achievedAt: longestDuration.startedAt,
        ),
      );
    }
    if (fastestPace != null) {
      records.add(
        PersonalRecord(
          type: PersonalRecordType.fastestPace,
          value: fastestPace.avgPaceSecPerKm,
          walkId: fastestPace.id,
          achievedAt: fastestPace.startedAt,
        ),
      );
    }
    if (mostCalories != null) {
      records.add(
        PersonalRecord(
          type: PersonalRecordType.mostCalories,
          value: mostCalories.caloriesKcal,
          walkId: mostCalories.id,
          achievedAt: mostCalories.startedAt,
        ),
      );
    }
    if (mostSteps != null) {
      records.add(
        PersonalRecord(
          type: PersonalRecordType.mostSteps,
          value: mostSteps.steps.toDouble(),
          walkId: mostSteps.id,
          achievedAt: mostSteps.startedAt,
        ),
      );
    }
    return records;
  }

  @override
  Future<List<Achievement>> getAchievements(String userId) async {
    final lifetime = await getLifetimeStats(userId);
    final walks = await getCompletedWalks(userId);
    return _evaluateAchievements.call(lifetime: lifetime, walks: walks);
  }
}

final statsRepositoryProvider = Provider<StatsRepository>((ref) {
  return StatsRepositoryImpl(
    local: ref.watch(walkLocalDataSourceProvider),
    firestore: ref.watch(firebaseFirestoreProvider),
  );
});
