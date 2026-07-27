import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/statistics/data/repositories/stats_repository_impl.dart';
import 'package:paceflow/shared/extensions/context_ext.dart';
import 'package:paceflow/shared/widgets/loading_overlay.dart';
import 'package:paceflow/shared/widgets/pf_app_bar.dart';
import 'package:paceflow/shared/widgets/pf_button.dart';

class ExportDataPage extends ConsumerStatefulWidget {
  const ExportDataPage({super.key});

  static const routePath = '/settings/export';
  static const routeName = 'exportData';

  @override
  ConsumerState<ExportDataPage> createState() => _ExportDataPageState();
}

class _ExportDataPageState extends ConsumerState<ExportDataPage> {
  bool _exporting = false;

  Future<void> _export() async {
    final user = ref.read(authControllerProvider).user;
    if (user == null) return;

    setState(() => _exporting = true);
    try {
      final walks = await ref.read(statsRepositoryProvider).getCompletedWalks(user.uid);
      final payload = {
        'exportedAt': DateTime.now().toUtc().toIso8601String(),
        'user': {
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName,
        },
        'walks': walks.map((w) {
          return {
            'id': w.id,
            'title': w.title,
            'startedAt': w.startedAt.toUtc().toIso8601String(),
            'endedAt': w.endedAt?.toUtc().toIso8601String(),
            'durationMs': w.durationMs,
            'distanceMeters': w.distanceMeters,
            'avgPaceSecPerKm': w.avgPaceSecPerKm,
            'caloriesKcal': w.caloriesKcal,
            'steps': w.steps,
            'elevationGainM': w.elevationGainM,
            'polylineEncoded': w.polylineEncoded,
            'pointCount': w.pointCount,
          };
        }).toList(),
      };

      final jsonStr = const JsonEncoder.withIndent('  ').convert(payload);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/paceflow_export_${user.uid}.json');
      await file.writeAsString(jsonStr);

      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/json')],
        subject: 'PaceFlow Data Export',
      );

      if (mounted) context.showSnackBar('Export ready to share');
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Export failed: $error', isError: true);
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PfAppBar(
        title: 'Export Data',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: AppSpacings.pageInsets,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Export your walks',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacings.sm),
                Text(
                  'Download a JSON file containing your completed walk summaries. '
                  'Route polylines are included; GPS point details remain on device unless synced.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                PfButton(
                  label: 'Export JSON',
                  icon: Icons.file_download_rounded,
                  onPressed: _exporting ? null : _export,
                  isLoading: _exporting,
                ),
                const SizedBox(height: AppSpacings.lg),
              ],
            ),
          ),
          LoadingOverlay(visible: _exporting, message: 'Preparing export…'),
        ],
      ),
    );
  }
}
