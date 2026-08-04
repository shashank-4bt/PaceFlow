import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_spacings.dart';
import 'app_typography.dart';

/// Material 3 light and dark themes for PaceFlow.
abstract final class AppTheme {
  static ThemeData get light => _buildTheme(Brightness.light);

  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = isDark ? _darkColorScheme : _lightColorScheme;
    final textTheme = isDark ? AppTypography.darkTextTheme : AppTypography.lightTextTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor:
          isDark ? AppColors.primaryBlack : AppColors.surfaceLight,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacings.borderRadiusLg,
          side: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? AppColors.surfaceDark
            : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.lg,
          vertical: AppSpacings.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppSpacings.borderRadiusMd,
          borderSide: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.black.withValues(alpha: 0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacings.borderRadiusMd,
          borderSide: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.black.withValues(alpha: 0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacings.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.emerald, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacings.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSpacings.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.emerald,
          foregroundColor: AppColors.primaryBlack,
          minimumSize: const Size.fromHeight(AppSpacings.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacings.borderRadiusMd,
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          minimumSize: const Size.fromHeight(AppSpacings.buttonHeight),
          side: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.15),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacings.borderRadiusMd,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.emerald,
          textStyle: textTheme.labelLarge,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.08),
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? AppColors.cardDark : AppColors.textPrimaryLight,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? AppColors.white : AppColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacings.borderRadiusMd,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.emerald,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.emerald;
          }
          return null;
        }),
        checkColor: WidgetStateProperty.all(AppColors.primaryBlack),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.emerald,
        foregroundColor: AppColors.primaryBlack,
        elevation: 4,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.white,
        selectedItemColor: AppColors.emerald,
        unselectedItemColor: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.emerald,
    onPrimary: AppColors.primaryBlack,
    secondary: AppColors.electricBlue,
    onSecondary: AppColors.white,
    tertiary: AppColors.purple,
    onTertiary: AppColors.white,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    surfaceContainerHighest: AppColors.cardLight,
    onSurfaceVariant: AppColors.textSecondaryLight,
    outline: Color(0xFFE2E8F0),
    shadow: Colors.black26,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.emerald,
    onPrimary: AppColors.primaryBlack,
    secondary: AppColors.electricBlue,
    onSecondary: AppColors.white,
    tertiary: AppColors.purple,
    onTertiary: AppColors.white,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.primaryBlack,
    onSurface: AppColors.textPrimaryDark,
    surfaceContainerHighest: AppColors.cardDark,
    onSurfaceVariant: AppColors.textSecondaryDark,
    outline: Color(0xFF2A2A2A),
    shadow: Colors.black54,
  );
}
