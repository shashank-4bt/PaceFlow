import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography system: Plus Jakarta Sans (UI) + Space Grotesk (display/metrics).
abstract final class AppTypography {
  static TextTheme lightTextTheme = _buildTextTheme(
    baseColor: AppColors.textPrimaryLight,
    secondaryColor: AppColors.textSecondaryLight,
  );

  static TextTheme darkTextTheme = _buildTextTheme(
    baseColor: AppColors.textPrimaryDark,
    secondaryColor: AppColors.textSecondaryDark,
  );

  static TextTheme _buildTextTheme({
    required Color baseColor,
    required Color secondaryColor,
  }) {
    final jakarta = GoogleFonts.plusJakartaSansTextTheme();
    final grotesk = GoogleFonts.spaceGroteskTextTheme();

    return TextTheme(
      displayLarge: grotesk.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: baseColor,
        letterSpacing: -1.2,
      ),
      displayMedium: grotesk.displayMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: baseColor,
        letterSpacing: -0.8,
      ),
      displaySmall: grotesk.displaySmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: baseColor,
        letterSpacing: -0.5,
      ),
      headlineLarge: grotesk.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: baseColor,
      ),
      headlineMedium: grotesk.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      headlineSmall: jakarta.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleLarge: jakarta.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleMedium: jakarta.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleSmall: jakarta.titleSmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
      bodyLarge: jakarta.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        color: baseColor,
      ),
      bodyMedium: jakarta.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: baseColor,
      ),
      bodySmall: jakarta.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        color: secondaryColor,
      ),
      labelLarge: jakarta.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: baseColor,
        letterSpacing: 0.2,
      ),
      labelMedium: jakarta.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      labelSmall: jakarta.labelSmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.4,
      ),
    );
  }

  /// Space Grotesk style for large metric numbers on tracking screens.
  static TextStyle metricStyle({
    required Color color,
    double fontSize = 48,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: -1,
    );
  }
}
