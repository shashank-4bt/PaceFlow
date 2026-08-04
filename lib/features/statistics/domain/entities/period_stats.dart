import 'package:equatable/equatable.dart';

class DailyDistance {
  const DailyDistance({
    required this.date,
    required this.distanceMeters,
    required this.walkCount,
    required this.durationMs,
    required this.caloriesKcal,
  });

  final DateTime date;
  final double distanceMeters;
  final int walkCount;
  final int durationMs;
  final double caloriesKcal;
}

class PeriodStats extends Equatable {
  const PeriodStats({
    required this.start,
    required this.end,
    this.totalDistanceMeters = 0,
    this.totalWalks = 0,
    this.totalDurationMs = 0,
    this.totalCaloriesKcal = 0,
    this.totalSteps = 0,
    this.avgPaceSecPerKm = 0,
    this.dailyDistances = const [],
  });

  final DateTime start;
  final DateTime end;
  final double totalDistanceMeters;
  final int totalWalks;
  final int totalDurationMs;
  final double totalCaloriesKcal;
  final int totalSteps;
  final double avgPaceSecPerKm;
  final List<DailyDistance> dailyDistances;

  @override
  List<Object?> get props => [
        start,
        end,
        totalDistanceMeters,
        totalWalks,
        totalDurationMs,
        totalCaloriesKcal,
        totalSteps,
        avgPaceSecPerKm,
        dailyDistances,
      ];
}
