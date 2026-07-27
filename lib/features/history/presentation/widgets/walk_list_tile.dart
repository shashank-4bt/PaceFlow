import 'package:flutter/material.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/core/utils/formatters.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';

class WalkListTile extends StatelessWidget {
  const WalkListTile({
    super.key,
    required this.walk,
    required this.useMiles,
    this.onTap,
  });

  final WalkDto walk;
  final bool useMiles;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacings.borderRadiusLg,
        child: Padding(
          padding: AppSpacings.cardInsets,
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.emerald.withValues(alpha: 0.15),
                  borderRadius: AppSpacings.borderRadiusMd,
                ),
                child: const Icon(
                  Icons.directions_walk_rounded,
                  color: AppColors.emerald,
                ),
              ),
              const SizedBox(width: AppSpacings.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      walk.title ?? Formatters.dateShort(walk.startedAt),
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      Formatters.dateTimeShort(walk.startedAt),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Formatters.distanceMeters(
                      walk.distanceMeters,
                      useMiles: useMiles,
                    ),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.emerald,
                    ),
                  ),
                  Text(
                    Formatters.durationMs(walk.durationMs, compact: true),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
