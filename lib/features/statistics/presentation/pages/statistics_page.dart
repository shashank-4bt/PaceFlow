import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/features/settings/presentation/controllers/settings_controller.dart';
import 'package:paceflow/features/statistics/presentation/controllers/stats_controller.dart';
import 'package:paceflow/features/statistics/presentation/widgets/badge_grid.dart';
import 'package:paceflow/features/statistics/presentation/widgets/distance_chart.dart';
import 'package:paceflow/features/statistics/presentation/widgets/records_list.dart';
import 'package:paceflow/features/statistics/presentation/widgets/stats_summary_header.dart';
import 'package:paceflow/shared/widgets/loading_overlay.dart';
import 'package:paceflow/shared/widgets/pf_app_bar.dart';

class StatisticsPage extends ConsumerWidget {
  const StatisticsPage({super.key});

  static const routePath = '/stats';
  static const routeName = 'stats';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(statsControllerProvider);
    final controller = ref.read(statsControllerProvider.notifier);
    final useMiles = ref.watch(settingsControllerProvider).usesMiles;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const PfAppBar(title: 'Statistics'),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: controller.refresh,
            child: ListView(
              padding: AppSpacings.pageInsets,
              children: [
                if (state.lifetime != null)
                  StatsSummaryHeader(
                    lifetime: state.lifetime!,
                    useMiles: useMiles,
                  ),
                const SizedBox(height: AppSpacings.lg),
                SegmentedButton<StatsPeriod>(
                  segments: const [
                    ButtonSegment(
                      value: StatsPeriod.week,
                      label: Text('Week'),
                    ),
                    ButtonSegment(
                      value: StatsPeriod.month,
                      label: Text('Month'),
                    ),
                    ButtonSegment(
                      value: StatsPeriod.year,
                      label: Text('Year'),
                    ),
                  ],
                  selected: {state.period},
                  onSelectionChanged: (selection) {
                    controller.setPeriod(selection.first);
                  },
                ),
                const SizedBox(height: AppSpacings.lg),
                Text('Distance', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacings.sm),
                if (state.periodStats != null)
                  DistanceChart(
                    periodStats: state.periodStats!,
                    useMiles: useMiles,
                  ),
                const SizedBox(height: AppSpacings.xl),
                Text('Personal Records', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacings.sm),
                RecordsList(records: state.records, useMiles: useMiles),
                const SizedBox(height: AppSpacings.xl),
                Text('Achievements', style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacings.sm),
                BadgeGrid(achievements: state.achievements),
              ],
            ),
          ),
          LoadingOverlay(visible: state.isLoading),
        ],
      ),
    );
  }
}
