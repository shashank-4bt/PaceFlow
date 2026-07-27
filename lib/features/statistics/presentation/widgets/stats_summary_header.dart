import 'package:flutter/material.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/app/theme/app_typography.dart';
import 'package:paceflow/core/utils/formatters.dart';
import 'package:paceflow/features/statistics/domain/entities/lifetime_stats.dart';

class StatsSummaryHeader extends StatelessWidget {
  const StatsSummaryHeader({
    super.key,
    required this.lifetime,
    required this.useMiles,
  });

  final LifetimeStats lifetime;
  final bool useMiles;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: AppSpacings.cardInsets,
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: AppSpacings.borderRadiusLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lifetime',
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: AppSpacings.sm),
          Text(
            Formatters.distanceMeters(
              lifetime.totalDistanceMeters,
              useMiles: useMiles,
              fractionDigits: 1,
            ),
            style: AppTypography.metricStyle(
              color: AppColors.white,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: AppSpacings.md),
          Row(
            children: [
              _MiniStat(
                label: 'Walks',
                value: '${lifetime.totalWalks}',
              ),
              const SizedBox(width: AppSpacings.xl),
              _MiniStat(
                label: 'Streak',
                value: '${lifetime.currentStreakDays}d',
              ),
              const SizedBox(width: AppSpacings.xl),
              _MiniStat(
                label: 'Calories',
                value: Formatters.calories(
                  lifetime.totalCaloriesKcal,
                  fractionDigits: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.white.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
