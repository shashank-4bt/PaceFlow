import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/features/statistics/domain/entities/period_stats.dart';

class DistanceChart extends StatelessWidget {
  const DistanceChart({
    super.key,
    required this.periodStats,
    required this.useMiles,
  });

  final PeriodStats periodStats;
  final bool useMiles;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = periodStats.dailyDistances;

    if (data.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'No data for this period',
            style: theme.textTheme.bodySmall,
          ),
        ),
      );
    }

    final spots = <BarChartGroupData>[];
    for (var i = 0; i < data.length; i++) {
      final km = data[i].distanceMeters / 1000;
      final value = useMiles ? km / 1.609344 : km;
      spots.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
              color: AppColors.emerald,
              width: 14,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ],
        ),
      );
    }

    final maxY = spots
        .map((g) => g.barRods.first.toY)
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: maxY <= 0 ? 1 : maxY * 1.2,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY > 0 ? maxY / 4 : 1,
            getDrawingHorizontalLine: (_) => FlLine(
              color: theme.dividerColor,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (value, meta) => Text(
                  value.toStringAsFixed(1),
                  style: theme.textTheme.labelSmall,
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= data.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: AppSpacings.xs),
                    child: Text(
                      DateFormat.Md().format(data[index].date),
                      style: theme.textTheme.labelSmall,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: spots,
        ),
      ),
    );
  }
}
