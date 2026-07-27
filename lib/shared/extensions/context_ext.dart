import 'package:flutter/material.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  bool get isDark => theme.brightness == Brightness.dark;

  Size get screenSize => MediaQuery.sizeOf(this);

  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : null,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppSpacings.lg),
      ),
    );
  }

  Future<T?> showAppDialog<T>({
    required String title,
    required String message,
    String confirmLabel = 'OK',
    String? cancelLabel,
    bool destructive = false,
  }) {
    return showDialog<T>(
      context: this,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelLabel != null)
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(cancelLabel),
            ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: destructive
                ? TextButton.styleFrom(foregroundColor: AppColors.error)
                : null,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }
}
