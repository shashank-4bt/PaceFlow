import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';
import 'package:paceflow/features/tracking/presentation/controllers/walk_session_controller.dart';
import 'package:paceflow/features/tracking/presentation/pages/walk_summary_page.dart';
import 'package:paceflow/features/tracking/presentation/widgets/live_stats_bar.dart';
import 'package:paceflow/features/tracking/presentation/widgets/route_map.dart';
import 'package:paceflow/features/tracking/presentation/widgets/tracking_controls.dart';

class ActiveTrackingPage extends ConsumerStatefulWidget {
  const ActiveTrackingPage({super.key});

  static const routePath = '/track';
  static const routeName = 'track';

  @override
  ConsumerState<ActiveTrackingPage> createState() => _ActiveTrackingPageState();
}

class _ActiveTrackingPageState extends ConsumerState<ActiveTrackingPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(walkSessionControllerProvider);
    final controller = ref.read(walkSessionControllerProvider.notifier);
    final session = state.session;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: RouteMap(
                points: session?.points ?? const [],
                followUser: session?.isActive ?? false,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.75),
                      Colors.black.withValues(alpha: 0),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _statusColor(session?.status)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _statusColor(session?.status)
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            _statusLabel(session?.status),
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'PaceFlow',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'Every step has a story',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.isLoading)
              const Positioned.fill(
                child: ColoredBox(
                  color: Color(0x88000000),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            if (state.errorMessage != null)
              Positioned(
                top: 120,
                left: 20,
                right: 20,
                child: Material(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(color: colorScheme.onErrorContainer),
                    ),
                  ),
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xFF0B0F14),
                      const Color(0xFF0B0F14).withValues(alpha: 0.95),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LiveStatsBar(metrics: session?.metrics),
                    const SizedBox(height: 20),
                    TrackingControls(
                      status: session?.status ?? WalkSessionStatus.idle,
                      onStart: () {
                        final userId = ref.read(currentUserIdProvider);
                        controller.startWalk(userId: userId);
                      },
                      onPause: controller.pauseWalk,
                      onResume: controller.resumeWalk,
                      onStop: () async {
                        final completed = await controller.stopWalk();
                        if (!context.mounted || completed == null) return;
                        await Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => WalkSummaryPage(session: completed),
                          ),
                        );
                      },
                      onDiscard: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Discard walk?'),
                            content: const Text(
                              'This walk will not be saved.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Discard'),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          await controller.discardWalk();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(WalkSessionStatus? status) {
    switch (status) {
      case WalkSessionStatus.active:
      case WalkSessionStatus.starting:
        return const Color(0xFF34D399);
      case WalkSessionStatus.paused:
        return const Color(0xFFFBBF24);
      case WalkSessionStatus.completed:
        return const Color(0xFF60A5FA);
      default:
        return Colors.white54;
    }
  }

  String _statusLabel(WalkSessionStatus? status) {
    switch (status) {
      case WalkSessionStatus.active:
        return 'Recording';
      case WalkSessionStatus.paused:
        return 'Paused';
      case WalkSessionStatus.starting:
        return 'Starting';
      case WalkSessionStatus.stopping:
        return 'Saving';
      case WalkSessionStatus.completed:
        return 'Completed';
      case WalkSessionStatus.idle:
      case null:
        return 'Ready';
    }
  }
}
