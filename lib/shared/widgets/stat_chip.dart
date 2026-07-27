import 'package:flutter/material.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/app/theme/app_typography.dart';

/// Compact metric chip used on dashboard and tracking surfaces.
class StatChip extends StatelessWidget {
  const StatChip({
    super.key,
    required this.label,
    required this.value,
    this.unit = '',
    this.icon,
    this.accentColor = AppColors.emerald,
  });

  final String label;
  final String value;
  final String unit;
  final IconData? icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final valueText = unit.isEmpty ? value : '$value $unit';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.md,
        vertical: AppSpacings.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: AppSpacings.borderRadiusMd,
        border: Border.all(
          color: accentColor.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: accentColor),
            const SizedBox(width: AppSpacings.xs),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall,
              ),
              Text(
                valueText,
                style: AppTypography.metricStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
