import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/core/constants/app_constants.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:paceflow/features/settings/presentation/pages/settings_page.dart';
import 'package:paceflow/shared/widgets/glass_container.dart';
import 'package:paceflow/shared/widgets/pf_button.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  static const routePath = '/profile';
  static const routeName = 'profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).user;
    final theme = Theme.of(context);

    if (user == null) {
      return const Center(child: Text('Not signed in'));
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: AppSpacings.pageInsets,
            child: Column(
              children: [
                const SizedBox(height: AppSpacings.lg),
                CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.emerald.withValues(alpha: 0.2),
                  backgroundImage: user.photoUrl != null
                      ? CachedNetworkImageProvider(user.photoUrl!)
                      : null,
                  child: user.photoUrl == null
                      ? Text(
                          user.displayName.isNotEmpty
                              ? user.displayName[0].toUpperCase()
                              : '?',
                          style: theme.textTheme.headlineMedium,
                        )
                      : null,
                ),
                const SizedBox(height: AppSpacings.md),
                Text(user.displayName, style: theme.textTheme.headlineSmall),
                Text(
                  user.email,
                  style: theme.textTheme.bodySmall,
                ),
                if (user.bio != null && user.bio!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacings.sm),
                  Text(
                    user.bio!,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: AppSpacings.lg),
                GlassContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ProfileStat(
                        label: 'Weight',
                        value: '${user.weightKg.toStringAsFixed(1)} kg',
                      ),
                      _ProfileStat(
                        label: 'Units',
                        value: user.usesMiles ? 'Miles' : 'Kilometers',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacings.lg),
                PfButton(
                  label: 'Edit Profile',
                  variant: PfButtonVariant.outline,
                  icon: Icons.edit_rounded,
                  onPressed: () => context.push(EditProfilePage.routePath),
                ),
                const SizedBox(height: AppSpacings.sm),
                PfButton(
                  label: 'Settings',
                  variant: PfButtonVariant.ghost,
                  icon: Icons.settings_rounded,
                  onPressed: () => context.push(SettingsPage.routePath),
                ),
                const SizedBox(height: AppSpacings.xl),
                Text(
                  '${AppConstants.appName} v${AppConstants.appVersion}',
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(label, style: theme.textTheme.labelSmall),
        Text(value, style: theme.textTheme.titleMedium),
      ],
    );
  }
}
