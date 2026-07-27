import 'package:paceflow/features/statistics/domain/entities/period_stats.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';

class ComputePeriodStats {
  PeriodStats call({
    required DateTime start,
    required DateTime end,
    required List<WalkDto> walks,
  }) {
    final startDay = DateTime(start.year, start.month, start.day);
    final endDay = DateTime(end.year, end.month, end.day);

    final filtered = walks.where((w) {
      if (w.status != 'completed') return false;
      final day = DateTime(
        w.startedAt.year,
        w.startedAt.month,
        w.startedAt.day,
      );
      return !day.isBefore(startDay) && !day.isAfter(endDay);
    }).toList();

    var totalDistance = 0.0;
    var totalDuration = 0;
    var totalCalories = 0.0;
    var totalSteps = 0;
    var paceSum = 0.0;
    var paceCount = 0;

    final dailyMap = <DateTime, DailyDistance>{};

    for (final walk in filtered) {
      totalDistance += walk.distanceMeters;
      totalDuration += walk.durationMs;
      totalCalories += walk.caloriesKcal;
      totalSteps += walk.steps;
      if (walk.avgPaceSecPerKm > 0) {
        paceSum += walk.avgPaceSecPerKm;
        paceCount++;
      }

      final day = DateTime(
        walk.startedAt.year,
        walk.startedAt.month,
        walk.startedAt.day,
      );
      final existing = dailyMap[day];
      dailyMap[day] = DailyDistance(
        date: day,
        distanceMeters:
            (existing?.distanceMeters ?? 0) + walk.distanceMeters,
        walkCount: (existing?.walkCount ?? 0) + 1,
        durationMs: (existing?.durationMs ?? 0) + walk.durationMs,
        caloriesKcal: (existing?.caloriesKcal ?? 0) + walk.caloriesKcal,
      );
    }

    final dailyDistances = dailyMap.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return PeriodStats(
      start: startDay,
      end: endDay,
      totalDistanceMeters: totalDistance,
      totalWalks: filtered.length,
      totalDurationMs: totalDuration,
      totalCaloriesKcal: totalCalories,
      totalSteps: totalSteps,
      avgPaceSecPerKm: paceCount > 0 ? paceSum / paceCount : 0,
      dailyDistances: dailyDistances,
    );
  }
}
