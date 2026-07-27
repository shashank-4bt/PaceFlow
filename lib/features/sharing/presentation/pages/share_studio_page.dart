import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/history/presentation/controllers/history_controller.dart';
import 'package:paceflow/features/settings/presentation/controllers/settings_controller.dart';
import 'package:paceflow/features/sharing/domain/entities/share_card_config.dart';
import 'package:paceflow/features/sharing/presentation/controllers/share_controller.dart';
import 'package:paceflow/features/sharing/presentation/widgets/route_share_card.dart';
import 'package:paceflow/shared/extensions/context_ext.dart';
import 'package:paceflow/shared/widgets/loading_overlay.dart';
import 'package:paceflow/shared/widgets/pf_app_bar.dart';
import 'package:paceflow/shared/widgets/pf_button.dart';

class ShareStudioPage extends ConsumerWidget {
  const ShareStudioPage({super.key, required this.walkId});

  final String walkId;

  static const routePath = '/walk/:id/share';
  static const routeName = 'shareStudio';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walkAsync = ref.watch(walkDetailProvider(walkId));
    final shareState = ref.watch(shareControllerProvider);
    final shareController = ref.read(shareControllerProvider.notifier);
    final user = ref.watch(authControllerProvider).user;
    final useMiles = ref.watch(settingsControllerProvider).usesMiles;

    return walkAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: PfAppBar(
          title: 'Share Studio',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(child: Text(e.toString())),
      ),
      data: (walk) {
        if (walk == null) {
          return Scaffold(
            appBar: PfAppBar(
              title: 'Share Studio',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
            ),
            body: const Center(child: Text('Walk not found')),
          );
        }

        final previewScale = 0.42;
        final previewWidth = shareState.config.size.width * previewScale;
        final previewHeight = shareState.config.size.height * previewScale;

        return Scaffold(
          appBar: PfAppBar(
            title: 'Share Studio',
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: Stack(
            children: [
              ListView(
                padding: AppSpacings.pageInsets,
                children: [
                  Center(
                    child: FittedBox(
                      child: SizedBox(
                        width: previewWidth,
                        height: previewHeight,
                        child: RouteShareCard(
                          walk: walk,
                          config: shareState.config,
                          displayName: user?.displayName ?? 'Walker',
                          photoUrl: user?.photoUrl,
                          useMiles: useMiles,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacings.xl),
                  Text('Theme', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: AppSpacings.sm),
                  SegmentedButton<ShareCardTheme>(
                    segments: const [
                      ButtonSegment(
                        value: ShareCardTheme.dark,
                        label: Text('Dark'),
                      ),
                      ButtonSegment(
                        value: ShareCardTheme.light,
                        label: Text('Light'),
                      ),
                    ],
                    selected: {shareState.config.theme},
                    onSelectionChanged: (s) =>
                        shareController.setTheme(s.first),
                  ),
                  const SizedBox(height: AppSpacings.lg),
                  Text('Size', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: AppSpacings.sm),
                  Wrap(
                    spacing: AppSpacings.sm,
                    children: ShareCardSize.values.map((size) {
                      final selected = shareState.config.size == size;
                      return ChoiceChip(
                        label: Text('${size.label} (${size.aspectLabel})'),
                        selected: selected,
                        onSelected: (_) => shareController.setSize(size),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacings.lg),
                  Text(
                    'Gradient',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacings.sm),
                  Wrap(
                    spacing: AppSpacings.sm,
                    children: ShareGradientPreset.values.map((preset) {
                      final selected = shareState.config.gradient == preset;
                      return ChoiceChip(
                        label: Text(preset.label),
                        selected: selected,
                        onSelected: (_) =>
                            shareController.setGradient(preset),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacings.xxl),
                  PfButton(
                    label: 'Export & Share',
                    icon: Icons.ios_share_rounded,
                    onPressed: shareState.isExporting
                        ? null
                        : () async {
                            await shareController.shareWalk(
                              walk: walk,
                              useMiles: useMiles,
                            );
                            if (context.mounted) {
                              context.showSnackBar('Share card exported');
                            }
                          },
                  ),
                ],
              ),
              LoadingOverlay(
                visible: shareState.isExporting,
                message: 'Rendering hi-res card…',
              ),
            ],
          ),
        );
      },
    );
  }
}
