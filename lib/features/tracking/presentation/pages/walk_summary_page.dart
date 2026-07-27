import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';
import 'package:paceflow/features/tracking/presentation/widgets/live_stats_bar.dart';
import 'package:paceflow/features/tracking/presentation/widgets/route_map.dart';

class WalkSummaryPage extends StatelessWidget {
  const WalkSummaryPage({super.key, required this.session});

  final WalkSession session;

  @override
  Widget build(BuildContext context) {
    final metrics = session.metrics;
    final endedAt = session.endedAt ?? DateTime.now();
    final dateLabel = DateFormat.yMMMMd().add_jm().format(endedAt);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Walk Summary',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 280,
            child: RouteMap(points: session.points),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateLabel,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(metrics.distanceMeters / 1000).toStringAsFixed(2)} km walk',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LiveStatsBar(metrics: metrics),
                  const SizedBox(height: 24),
                  _DetailRow(
                    label: 'Elevation gain',
                    value: '${metrics.elevationGainM.toStringAsFixed(0)} m',
                  ),
                  _DetailRow(
                    label: 'Elevation loss',
                    value: '${metrics.elevationLossM.toStringAsFixed(0)} m',
                  ),
                  _DetailRow(
                    label: 'Max speed',
                    value:
                        '${(metrics.maxSpeedMps * 3.6).toStringAsFixed(1)} km/h',
                  ),
                  _DetailRow(
                    label: 'Route points',
                    value: '${metrics.pointCount}',
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).popUntil(
                        (route) => route.isFirst,
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF34D399),
                        foregroundColor: const Color(0xFF052E1C),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(color: Colors.white60),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
