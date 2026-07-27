import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:paceflow/features/tracking/domain/entities/walk_metrics.dart';

class LiveStatsBar extends StatelessWidget {
  const LiveStatsBar({super.key, this.metrics});

  final WalkMetrics? metrics;

  @override
  Widget build(BuildContext context) {
    final data = metrics ?? WalkMetrics.empty;
    final activeDuration = Duration(milliseconds: data.durationMs - data.pausedDurationMs);
    final pace = _formatPace(data.avgPaceSecPerKm);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151B23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatTile(
              label: 'Distance',
              value: (data.distanceMeters / 1000).toStringAsFixed(2),
              unit: 'km',
            ),
          ),
          _divider(),
          Expanded(
            child: _StatTile(
              label: 'Duration',
              value: _formatDuration(activeDuration),
              unit: '',
            ),
          ),
          _divider(),
          Expanded(
            child: _StatTile(
              label: 'Pace',
              value: pace,
              unit: '/km',
            ),
          ),
          _divider(),
          Expanded(
            child: _StatTile(
              label: 'Calories',
              value: data.caloriesKcal.round().toString(),
              unit: 'kcal',
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 44,
      color: Colors.white.withValues(alpha: 0.08),
    );
  }

  static String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  static String _formatPace(double paceSecPerKm) {
    if (paceSecPerKm <= 0) return '--:--';
    final totalSeconds = paceSecPerKm.round();
    final minutes = totalSeconds ~/ 60;
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white54,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(text: value),
              if (unit.isNotEmpty)
                TextSpan(
                  text: ' $unit',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white54,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
