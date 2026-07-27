import 'package:paceflow/features/statistics/domain/entities/achievement.dart';
import 'package:paceflow/features/statistics/domain/entities/lifetime_stats.dart';
import 'package:paceflow/features/statistics/domain/entities/period_stats.dart';
import 'package:paceflow/features/statistics/domain/entities/personal_record.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';

abstract class StatsRepository {
  Future<LifetimeStats> getLifetimeStats(String userId);

  Future<PeriodStats> getPeriodStats(
    String userId, {
    required DateTime start,
    required DateTime end,
  });

  Future<List<PersonalRecord>> getPersonalRecords(String userId);

  Future<List<Achievement>> getAchievements(String userId);

  Future<List<WalkDto>> getCompletedWalks(String userId);
}
