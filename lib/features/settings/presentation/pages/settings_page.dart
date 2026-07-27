import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/core/constants/app_constants.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/settings/presentation/controllers/settings_controller.dart';
import 'package:paceflow/features/settings/presentation/pages/export_data_page.dart';
import 'package:paceflow/shared/extensions/context_ext.dart';
import 'package:paceflow/shared/widgets/pf_app_bar.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static const routePath = '/settings';
  static const routeName = 'settings';

  Future<void> _showLegal(BuildContext context, String asset) async {
    try {
      final html = await rootBundle.loadString('assets/legal/$asset');
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(asset.replaceAll('_', ' ').split('.').first),
          content: SingleChildScrollView(
            child: Text(
              html.replaceAll(RegExp(r'<[^>]*>'), ' ').replaceAll(RegExp(r'\s+'), ' ').trim(),
              style: Theme.of(ctx).textTheme.bodySmall,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (_) {
      if (context.mounted) {
        context.showSnackBar('Legal document not found in assets');
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final auth = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: PfAppBar(
        title: 'Settings',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        children: [
          const _SectionHeader('Preferences'),
          ListTile(
            title: const Text('Units'),
            subtitle: Text(settings.usesMiles ? 'Miles' : 'Kilometers'),
            trailing: DropdownButton<String>(
              value: settings.units,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(value: AppConstants.unitsKm, child: Text('km')),
                DropdownMenuItem(value: AppConstants.unitsMi, child: Text('mi')),
              ],
              onChanged: (v) {
                if (v != null) controller.setUnits(v);
              },
            ),
          ),
          ListTile(
            title: const Text('Theme'),
            subtitle: Text(settings.themeMode),
            trailing: DropdownButton<String>(
              value: settings.themeMode,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(value: 'system', child: Text('System')),
                DropdownMenuItem(value: 'light', child: Text('Light')),
                DropdownMenuItem(value: 'dark', child: Text('Dark')),
              ],
              onChanged: (v) {
                if (v != null) controller.setThemeMode(v);
              },
            ),
          ),
          const _SectionHeader('Notifications'),
          SwitchListTile(
            title: const Text('Daily walk reminder'),
            value: settings.dailyReminder,
            onChanged: (v) => controller.setDailyReminder(enabled: v),
          ),
          ListTile(
            title: const Text('Reminder time'),
            subtitle: Text(
              '${settings.dailyReminderHour.toString().padLeft(2, '0')}:'
              '${settings.dailyReminderMinute.toString().padLeft(2, '0')}',
            ),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: settings.dailyReminderHour,
                  minute: settings.dailyReminderMinute,
                ),
              );
              if (time != null) {
                await controller.setDailyReminder(
                  enabled: settings.dailyReminder,
                  hour: time.hour,
                  minute: time.minute,
                );
              }
            },
          ),
          SwitchListTile(
            title: const Text('Weekly summary'),
            value: settings.weeklySummary,
            onChanged: controller.setWeeklySummary,
          ),
          SwitchListTile(
            title: const Text('Goal completed'),
            value: settings.goalCompleted,
            onChanged: controller.setGoalCompleted,
          ),
          SwitchListTile(
            title: const Text('Milestones'),
            value: settings.milestones,
            onChanged: controller.setMilestones,
          ),
          const _SectionHeader('Privacy'),
          SwitchListTile(
            title: const Text('Share stats publicly'),
            value: settings.shareStatsPublicly,
            onChanged: controller.setShareStatsPublicly,
          ),
          SwitchListTile(
            title: const Text('Store precise location'),
            value: settings.storePreciseLocation,
            onChanged: controller.setStorePreciseLocation,
          ),
          const _SectionHeader('Data'),
          ListTile(
            leading: const Icon(Icons.download_rounded),
            title: const Text('Export data'),
            subtitle: const Text('Download walks as JSON'),
            onTap: () => context.push(ExportDataPage.routePath),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever_rounded),
            title: const Text('Delete account'),
            textColor: Theme.of(context).colorScheme.error,
            iconColor: Theme.of(context).colorScheme.error,
            onTap: () async {
              final confirmed = await context.showAppDialog<bool>(
                title: 'Delete account?',
                message:
                    'This permanently deletes your account and all walk data.',
                confirmLabel: 'Delete',
                cancelLabel: 'Cancel',
                destructive: true,
              );
              if (confirmed == true) {
                final ok = await auth.deleteAccount();
                if (context.mounted) {
                  if (ok) {
                    context.go('/auth/sign-in');
                  } else {
                    context.showSnackBar('Could not delete account', isError: true);
                  }
                }
              }
            },
          ),
          const _SectionHeader('Legal'),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () => _showLegal(context, 'privacy_policy.html'),
          ),
          ListTile(
            title: const Text('Terms of Service'),
            onTap: () => _showLegal(context, 'terms_of_service.html'),
          ),
          const SizedBox(height: AppSpacings.xxl),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacings.lg,
        AppSpacings.lg,
        AppSpacings.lg,
        AppSpacings.sm,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
