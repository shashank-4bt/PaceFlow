import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/core/constants/app_constants.dart';

enum ShareCardTheme { dark, light }

enum ShareCardSize {
  story(
    AppConstants.shareStoryWidth,
    AppConstants.shareStoryHeight,
    'Story',
    '9:16',
  ),
  square(
    AppConstants.shareSquareWidth,
    AppConstants.shareSquareHeight,
    'Square',
    '1:1',
  ),
  wallpaper(
    AppConstants.shareWallpaperWidth,
    AppConstants.shareWallpaperHeight,
    'Wallpaper',
    '9:16 HD',
  );

  const ShareCardSize(this.width, this.height, this.label, this.aspectLabel);
  final int width;
  final int height;
  final String label;
  final String aspectLabel;
}

enum ShareGradientPreset {
  emerald(
    'Emerald',
    [AppColors.emerald, AppColors.electricBlue],
  ),
  sunset(
    'Sunset',
    [AppColors.sunsetOrange, AppColors.purple],
  ),
  purple(
    'Purple',
    [AppColors.purple, AppColors.purpleLight],
  ),
  midnight(
    'Midnight',
    [AppColors.primaryBlack, Color(0xFF1E293B)],
  );

  const ShareGradientPreset(this.label, this.colors);
  final String label;
  final List<Color> colors;
}

class ShareCardConfig extends Equatable {
  const ShareCardConfig({
    this.theme = ShareCardTheme.dark,
    this.size = ShareCardSize.story,
    this.gradient = ShareGradientPreset.emerald,
    this.showCalories = true,
    this.showPace = true,
    this.showDate = true,
    this.showRoute = true,
  });

  final ShareCardTheme theme;
  final ShareCardSize size;
  final ShareGradientPreset gradient;
  final bool showCalories;
  final bool showPace;
  final bool showDate;
  final bool showRoute;

  ShareCardConfig copyWith({
    ShareCardTheme? theme,
    ShareCardSize? size,
    ShareGradientPreset? gradient,
    bool? showCalories,
    bool? showPace,
    bool? showDate,
    bool? showRoute,
  }) {
    return ShareCardConfig(
      theme: theme ?? this.theme,
      size: size ?? this.size,
      gradient: gradient ?? this.gradient,
      showCalories: showCalories ?? this.showCalories,
      showPace: showPace ?? this.showPace,
      showDate: showDate ?? this.showDate,
      showRoute: showRoute ?? this.showRoute,
    );
  }

  @override
  List<Object?> get props => [
        theme,
        size,
        gradient,
        showCalories,
        showPace,
        showDate,
        showRoute,
      ];
}
