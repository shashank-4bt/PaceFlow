import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/statistics/data/repositories/stats_repository_impl.dart';
import 'package:paceflow/features/statistics/domain/entities/achievement.dart';
import 'package:paceflow/features/statistics/domain/entities/lifetime_stats.dart';
import 'package:paceflow/features/statistics/domain/entities/period_stats.dart';
import 'package:paceflow/features/statistics/domain/entities/personal_record.dart';
import 'package:paceflow/features/statistics/domain/repositories/stats_repository.dart';

enum StatsPeriod { week, month, year }

class StatsState {
  const StatsState({
    this.period = StatsPeriod.week,
    this.lifetime,
    this.periodStats,
    this.records = const [],
    this.achievements = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final StatsPeriod period;
  final LifetimeStats? lifetime;
  final PeriodStats? periodStats;
  final List<PersonalRecord> records;
  final List<Achievement> achievements;
  final bool isLoading;
  final String? errorMessage;

  StatsState copyWith({
    StatsPeriod? period,
    LifetimeStats? lifetime,
    PeriodStats? periodStats,
    List<PersonalRecord>? records,
    List<Achievement>? achievements,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StatsState(
      period: period ?? this.period,
      lifetime: lifetime ?? this.lifetime,
      periodStats: periodStats ?? this.periodStats,
      records: records ?? this.records,
      achievements: achievements ?? this.achievements,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class StatsController extends Notifier<StatsState> {
  StatsRepository get _repository => ref.read(statsRepositoryProvider);

  @override
  StatsState build() {
    Future.microtask(refresh);
    return const StatsState(isLoading: true);
  }

  Future<void> setPeriod(StatsPeriod period) async {
    state = state.copyWith(period: period);
    await _loadPeriodStats();
  }

  Future<void> refresh() async {
    final userId = ref.read(authControllerProvider).user?.uid;
    if (userId == null) {
      state = const StatsState();
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final lifetime = await _repository.getLifetimeStats(userId);
      final records = await _repository.getPersonalRecords(userId);
      final achievements = await _repository.getAchievements(userId);
      state = state.copyWith(
        lifetime: lifetime,
        records: records,
        achievements: achievements,
        isLoading: false,
      );
      await _loadPeriodStats();
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> _loadPeriodStats() async {
    final userId = ref.read(authControllerProvider).user?.uid;
    if (userId == null) return;

    final now = DateTime.now();
    final (start, end) = switch (state.period) {
      StatsPeriod.week => (
          now.subtract(Duration(days: now.weekday - 1)),
          now,
        ),
      StatsPeriod.month => (
          DateTime(now.year, now.month, 1),
          now,
        ),
      StatsPeriod.year => (
          DateTime(now.year, 1, 1),
          now,
        ),
    };

    final periodStats = await _repository.getPeriodStats(
      userId,
      start: start,
      end: end,
    );
    state = state.copyWith(periodStats: periodStats);
  }
}

final statsControllerProvider =
    NotifierProvider<StatsController, StatsState>(StatsController.new);
