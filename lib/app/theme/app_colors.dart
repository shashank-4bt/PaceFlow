import 'package:flutter/material.dart';

/// PaceFlow brand color tokens.
abstract final class AppColors {
  static const Color primaryBlack = Color(0xFF0B0B0B);
  static const Color emerald = Color(0xFF22C55E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color electricBlue = Color(0xFF3B82F6);
  static const Color sunsetOrange = Color(0xFFF97316);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleLight = Color(0xFFA855F7);

  static const Color surfaceDark = Color(0xFF141414);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color cardDark = Color(0xFF1A1A1A);
  static const Color cardLight = Color(0xFFFFFFFF);

  static const Color textPrimaryDark = white;
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);

  static const Color error = Color(0xFFEF4444);
  static const Color success = emerald;
  static const Color warning = sunsetOrange;

  static const Color glassLight = Color(0x33FFFFFF);
  static const Color glassDark = Color(0x33141414);
  static const Color glassBorderLight = Color(0x4DFFFFFF);
  static const Color glassBorderDark = Color(0x4D22C55E);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald, electricBlue],
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [sunsetOrange, purple],
  );

  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purple, purpleLight],
  );
}
