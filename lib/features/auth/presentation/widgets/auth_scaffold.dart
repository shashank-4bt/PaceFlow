import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacings.dart';
import '../../../../core/constants/app_constants.dart';

/// Shared scaffold for auth screens with gradient background and glass card.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.footer,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        AppColors.primaryBlack,
                        AppColors.surfaceDark,
                        AppColors.primaryBlack,
                      ]
                    : [
                        AppColors.surfaceLight,
                        AppColors.white,
                        const Color(0xFFEFFDF4),
                      ],
              ),
            ),
          ),
          Positioned(
            top: -80,
            right: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.emerald.withValues(alpha: 0.35),
                    AppColors.electricBlue.withValues(alpha: 0.25),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.purple.withValues(alpha: 0.25),
                    AppColors.purpleLight.withValues(alpha: 0.15),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacings.pageInsets,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacings.xl),
                  Text(
                    AppConstants.appName,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.emerald,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacings.sm),
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacings.sm),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacings.xxxl),
                  ClipRRect(
                    borderRadius: AppSpacings.borderRadiusXl,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        padding: AppSpacings.cardInsets,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.glassDark
                              : AppColors.glassLight,
                          borderRadius: AppSpacings.borderRadiusXl,
                          border: Border.all(
                            color: isDark
                                ? AppColors.glassBorderDark
                                : AppColors.glassBorderLight,
                          ),
                        ),
                        child: child,
                      ),
                    ),
                  ),
                  if (footer != null) ...[
                    const SizedBox(height: AppSpacings.xl),
                    footer!,
                  ],
                  const SizedBox(height: AppSpacings.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
