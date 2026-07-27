import 'package:flutter/material.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/app/theme/app_typography.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.gradient,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: AppSpacings.pageInsets,
      child: Column(
        children: [
          const Spacer(flex: 2),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: AppSpacings.borderRadiusXl,
              boxShadow: [
                BoxShadow(
                  color: AppColors.emerald.withValues(alpha: 0.35),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Icon(icon, size: 56, color: AppColors.white),
          ),
          const SizedBox(height: AppSpacings.xxxl),
          Text(
            title,
            style: theme.textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacings.sm),
          Text(
            subtitle,
            style: AppTypography.metricStyle(
              color: AppColors.emerald,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacings.lg),
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
