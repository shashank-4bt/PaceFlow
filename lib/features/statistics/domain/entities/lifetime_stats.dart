import 'package:equatable/equatable.dart';

class LifetimeStats extends Equatable {
  const LifetimeStats({
    this.totalDistanceMeters = 0,
    this.totalWalks = 0,
    this.totalDurationMs = 0,
    this.totalCaloriesKcal = 0,
    this.totalSteps = 0,
    this.currentStreakDays = 0,
    this.longestStreakDays = 0,
  });

  final double totalDistanceMeters;
  final int totalWalks;
  final int totalDurationMs;
  final double totalCaloriesKcal;
  final int totalSteps;
  final int currentStreakDays;
  final int longestStreakDays;

  LifetimeStats copyWith({
    double? totalDistanceMeters,
    int? totalWalks,
    int? totalDurationMs,
    double? totalCaloriesKcal,
    int? totalSteps,
    int? currentStreakDays,
    int? longestStreakDays,
  }) {
    return LifetimeStats(
      totalDistanceMeters: totalDistanceMeters ?? this.totalDistanceMeters,
      totalWalks: totalWalks ?? this.totalWalks,
      totalDurationMs: totalDurationMs ?? this.totalDurationMs,
      totalCaloriesKcal: totalCaloriesKcal ?? this.totalCaloriesKcal,
      totalSteps: totalSteps ?? this.totalSteps,
      currentStreakDays: currentStreakDays ?? this.currentStreakDays,
      longestStreakDays: longestStreakDays ?? this.longestStreakDays,
    );
  }

  @override
  List<Object?> get props => [
        totalDistanceMeters,
        totalWalks,
        totalDurationMs,
        totalCaloriesKcal,
        totalSteps,
        currentStreakDays,
        longestStreakDays,
      ];
}
