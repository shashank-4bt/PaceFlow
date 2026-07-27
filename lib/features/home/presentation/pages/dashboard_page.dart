import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/core/utils/formatters.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/history/presentation/widgets/walk_list_tile.dart';
import 'package:paceflow/features/home/presentation/providers/home_tab_provider.dart';
import 'package:paceflow/features/settings/presentation/controllers/settings_controller.dart';
import 'package:paceflow/features/statistics/data/repositories/stats_repository_impl.dart';
import 'package:paceflow/features/statistics/domain/usecases/compute_period_stats.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';
import 'package:paceflow/features/tracking/presentation/pages/active_tracking_page.dart';
import 'package:paceflow/shared/widgets/empty_state.dart';
import 'package:paceflow/shared/widgets/glass_container.dart';
import 'package:paceflow/shared/widgets/pf_button.dart';
import 'package:paceflow/shared/widgets/stat_chip.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  bool _loading = true;
  double _totalDistance = 0;
  int _streak = 0;
  int _totalWalks = 0;
  List<WalkDto> _recentWalks = [];
  List<FlSpot> _chartSpots = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final userId = ref.read(authControllerProvider).user?.uid;
    if (userId == null) {
      setState(() => _loading = false);
      return;
    }

    final repo = ref.read(statsRepositoryProvider);
    final lifetime = await repo.getLifetimeStats(userId);
    final walks = await repo.getCompletedWalks(userId);
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final period = ComputePeriodStats().call(
      start: weekStart,
      end: now,
      walks: walks,
    );

    final recent = walks
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));

    final spots = <FlSpot>[];
    for (var i = 0; i < period.dailyDistances.length; i++) {
      spots.add(
        FlSpot(
          i.toDouble(),
          period.dailyDistances[i].distanceMeters / 1000,
        ),
      );
    }

    if (mounted) {
      setState(() {
        _totalDistance = lifetime.totalDistanceMeters;
        _streak = lifetime.currentStreakDays;
        _totalWalks = lifetime.totalWalks;
        _recentWalks = recent.take(3).toList();
        _chartSpots = spots;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final useMiles = ref.watch(settingsControllerProvider).usesMiles;
    final user = ref.watch(authControllerProvider).user;

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacings.pageInsets,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey, ${user?.displayName.split(' ').first ?? 'Walker'}',
                    style: theme.textTheme.headlineMedium,
                  ),
                  Text(
                    'Every Step Has a Story.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacings.xl),
                  GlassContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'This Week',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacings.md),
                        SizedBox(
                          height: 120,
                          child: _chartSpots.isEmpty
                              ? Center(
                                  child: Text(
                                    'No walks yet this week',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                )
                              : LineChart(
                                  LineChartData(
                                    gridData: const FlGridData(show: false),
                                    titlesData: const FlTitlesData(show: false),
                                    borderData: FlBorderData(show: false),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: _chartSpots,
                                        isCurved: true,
                                        color: AppColors.emerald,
                                        barWidth: 3,
                                        dotData: const FlDotData(show: false),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          color: AppColors.emerald
                                              .withValues(alpha: 0.15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacings.lg),
                  Wrap(
                    spacing: AppSpacings.sm,
                    runSpacing: AppSpacings.sm,
                    children: [
                      StatChip(
                        label: 'Total',
                        value: Formatters.distanceMeters(
                          _totalDistance,
                          useMiles: useMiles,
                          fractionDigits: 1,
                        ),
                        icon: Icons.route,
                      ),
                      StatChip(
                        label: 'Streak',
                        value: '$_streak days',
                        icon: Icons.local_fire_department,
                        accentColor: AppColors.sunsetOrange,
                      ),
                      StatChip(
                        label: 'Walks',
                        value: '$_totalWalks',
                        icon: Icons.directions_walk,
                        accentColor: AppColors.electricBlue,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacings.xl),
                  PfButton(
                    label: 'Start Walk',
                    icon: Icons.play_arrow_rounded,
                    onPressed: () => context.push(ActiveTrackingPage.routePath),
                  ),
                  const SizedBox(height: AppSpacings.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Walks', style: theme.textTheme.titleMedium),
                      TextButton(
                        onPressed: () =>
                            ref.read(homeTabIndexProvider.notifier).state = 1,
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_recentWalks.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                title: 'No walks yet',
                message: 'Start your first walk to see it here.',
                icon: Icons.directions_walk_rounded,
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final walk = _recentWalks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacings.pagePadding,
                      vertical: AppSpacings.xs,
                    ),
                    child: WalkListTile(
                      walk: walk,
                      useMiles: useMiles,
                      onTap: () => context.push('/walk/${walk.id}'),
                    ),
                  );
                },
                childCount: _recentWalks.length,
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacings.xxl)),
        ],
      ),
    );
  }
}
