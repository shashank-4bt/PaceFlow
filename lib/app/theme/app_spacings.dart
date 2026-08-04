import 'package:flutter/material.dart';

/// Consistent spacing, radii, and layout tokens.
abstract final class AppSpacings {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const double buttonHeight = 52;
  static const double iconSize = 24;
  static const double iconSizeLg = 32;
  static const double avatarSize = 48;
  static const double avatarSizeLg = 80;

  static const double pagePadding = lg;
  static const double cardPadding = lg;
  static const double sectionGap = xl;

  static const BorderRadius borderRadiusSm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderRadiusMd = BorderRadius.all(Radius.circular(12));
  static const BorderRadius borderRadiusLg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius borderRadiusXl = BorderRadius.all(Radius.circular(24));

  static const EdgeInsets pageInsets = EdgeInsets.symmetric(
    horizontal: pagePadding,
    vertical: lg,
  );

  static const EdgeInsets cardInsets = EdgeInsets.all(cardPadding);
}
