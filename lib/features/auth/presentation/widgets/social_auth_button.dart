import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacings.dart';

enum SocialAuthProvider { google }

/// Outlined social sign-in button with brand styling.
class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.isLoading = false,
  });

  final SocialAuthProvider provider;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final label = switch (provider) {
      SocialAuthProvider.google => 'Continue with Google',
    };

    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ProviderIcon(provider: provider),
                const SizedBox(width: AppSpacings.md),
                Text(label),
              ],
            ),
    );
  }
}

class _ProviderIcon extends StatelessWidget {
  const _ProviderIcon({required this.provider});

  final SocialAuthProvider provider;

  @override
  Widget build(BuildContext context) {
    return switch (provider) {
      SocialAuthProvider.google => Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black12),
          ),
          alignment: Alignment.center,
          child: const Text(
            'G',
            style: TextStyle(
              color: AppColors.electricBlue,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
    };
  }
}
