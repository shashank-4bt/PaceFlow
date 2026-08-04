import 'package:flutter/material.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/core/utils/formatters.dart';
import 'package:paceflow/features/statistics/domain/entities/achievement.dart';

class BadgeGrid extends StatelessWidget {
  const BadgeGrid({super.key, required this.achievements});

  final List<Achievement> achievements;

  IconData _iconFor(String name) {
    switch (name) {
      case 'route':
        return Icons.route_rounded;
      case 'hiking':
        return Icons.hiking_rounded;
      case 'emoji_events':
        return Icons.emoji_events_rounded;
      case 'local_fire_department':
        return Icons.local_fire_department_rounded;
      case 'whatshot':
        return Icons.whatshot_rounded;
      case 'repeat':
        return Icons.repeat_rounded;
      case 'star':
        return Icons.star_rounded;
      default:
        return Icons.directions_walk_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSpacings.sm,
        mainAxisSpacing: AppSpacings.sm,
        childAspectRatio: 0.85,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final badge = achievements[index];
        final unlocked = badge.isUnlocked;

        return Container(
          padding: const EdgeInsets.all(AppSpacings.sm),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: AppSpacings.borderRadiusMd,
            border: Border.all(
              color: unlocked
                  ? AppColors.emerald.withValues(alpha: 0.5)
                  : theme.dividerColor,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _iconFor(badge.iconName),
                size: 32,
                color: unlocked
                    ? AppColors.emerald
                    : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              ),
              const SizedBox(height: AppSpacings.xs),
              Text(
                badge.title,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (unlocked && badge.unlockedAt != null)
                Text(
                  Formatters.dateShort(badge.unlockedAt!),
                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
                ),
            ],
          ),
        );
      },
    );
  }
}
