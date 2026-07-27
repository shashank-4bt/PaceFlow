import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/features/history/presentation/controllers/history_controller.dart';
import 'package:paceflow/features/history/presentation/widgets/walk_list_tile.dart';
import 'package:paceflow/features/settings/presentation/controllers/settings_controller.dart';
import 'package:paceflow/shared/widgets/empty_state.dart';
import 'package:paceflow/shared/widgets/loading_overlay.dart';
import 'package:paceflow/shared/widgets/pf_app_bar.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  static const routePath = '/history';
  static const routeName = 'history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historyControllerProvider);
    final useMiles = ref.watch(settingsControllerProvider).usesMiles;

    return Scaffold(
      appBar: const PfAppBar(title: 'History'),
      body: Stack(
        children: [
          if (state.walks.isEmpty && !state.isLoading)
            EmptyState(
              title: 'No walks recorded',
              message: 'Your completed walks will appear here.',
              actionLabel: 'Refresh',
              onAction: () =>
                  ref.read(historyControllerProvider.notifier).refresh(),
            )
          else
            RefreshIndicator(
              onRefresh: () =>
                  ref.read(historyControllerProvider.notifier).refresh(),
              child: ListView.separated(
                padding: AppSpacings.pageInsets,
                itemCount: state.walks.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacings.sm),
                itemBuilder: (context, index) {
                  final walk = state.walks[index];
                  return WalkListTile(
                    walk: walk,
                    useMiles: useMiles,
                    onTap: () => context.push('/walk/${walk.id}'),
                  );
                },
              ),
            ),
          LoadingOverlay(visible: state.isLoading),
        ],
      ),
    );
  }
}
