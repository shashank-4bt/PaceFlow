import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';

class TrackingControls extends StatelessWidget {
  const TrackingControls({
    super.key,
    required this.status,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onStop,
    required this.onDiscard,
  });

  final WalkSessionStatus status;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final Future<void> Function() onStop;
  final Future<void> Function() onDiscard;

  @override
  Widget build(BuildContext context) {
    final isIdle = status == WalkSessionStatus.idle;
    final isActive =
        status == WalkSessionStatus.active || status == WalkSessionStatus.starting;
    final isPaused = status == WalkSessionStatus.paused;
    final isBusy = status == WalkSessionStatus.stopping;

    return Column(
      children: [
        Row(
          children: [
            if (!isIdle)
              Expanded(
                child: OutlinedButton(
                  onPressed: isBusy ? null : () => onDiscard(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Discard',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            if (!isIdle) const SizedBox(width: 12),
            Expanded(
              flex: isIdle ? 1 : 2,
              child: FilledButton(
                onPressed: isBusy
                    ? null
                    : () {
                        if (isIdle) {
                          onStart();
                        } else if (isActive) {
                          onPause();
                        } else if (isPaused) {
                          onResume();
                        }
                      },
                style: FilledButton.styleFrom(
                  backgroundColor: isPaused
                      ? const Color(0xFF34D399)
                      : isActive
                          ? const Color(0xFFFBBF24)
                          : const Color(0xFF34D399),
                  foregroundColor: const Color(0xFF052E1C),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isIdle
                      ? 'Start Walk'
                      : isActive
                          ? 'Pause'
                          : isPaused
                              ? 'Resume'
                              : 'Start Walk',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!isIdle) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: (isActive || isPaused) && !isBusy ? () => onStop() : null,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                isBusy ? 'Saving…' : 'Finish Walk',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
