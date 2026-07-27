import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/core/constants/app_constants.dart';
import 'package:paceflow/core/utils/formatters.dart';
import 'package:paceflow/features/sharing/domain/entities/share_card_config.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/services/polyline_encoder.dart';

class RouteShareCard extends StatelessWidget {
  const RouteShareCard({
    super.key,
    required this.walk,
    required this.config,
    required this.displayName,
    required this.useMiles,
    this.photoUrl,
  });

  final WalkDto walk;
  final ShareCardConfig config;
  final String displayName;
  final String? photoUrl;
  final bool useMiles;

  List<GeoPoint> get _routePoints {
    if (walk.points.isNotEmpty) {
      return walk.points.where((p) => !p.isFiltered).toList();
    }
    if (walk.polylineEncoded != null && walk.polylineEncoded!.isNotEmpty) {
      return PolylineEncoder.decode(walk.polylineEncoded!);
    }
    return const [];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = config.theme == ShareCardTheme.dark;
    final textColor = isDark ? AppColors.white : AppColors.textPrimaryLight;
    final subColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final aspect = config.size.height / config.size.width;

    return Container(
      width: config.size.width.toDouble(),
      height: config.size.height.toDouble(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: config.gradient.colors,
        ),
      ),
      child: Stack(
        children: [
          if (config.showRoute)
            Positioned.fill(
              child: CustomPaint(
                painter: _RoutePainter(
                  points: _routePoints,
                  color: AppColors.white.withValues(alpha: 0.85),
                  strokeWidth: config.size == ShareCardSize.square ? 6 : 8,
                ),
              ),
            ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: isDark ? 0.35 : 0.15),
                    Colors.black.withValues(alpha: isDark ? 0.55 : 0.35),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: config.size.width * 0.08,
              vertical: config.size.height * 0.06,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: aspect > 1.5 ? 36 : 28,
                      backgroundColor: AppColors.white.withValues(alpha: 0.2),
                      backgroundImage:
                          photoUrl != null ? CachedNetworkImageProvider(photoUrl!) : null,
                      child: photoUrl == null
                          ? Icon(Icons.person, color: textColor, size: 28)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName,
                            style: GoogleFonts.plusJakartaSans(
                              color: textColor,
                              fontSize: aspect > 1.5 ? 22 : 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            AppConstants.appName,
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.emerald,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  Formatters.distanceValueOnly(
                    walk.distanceMeters,
                    useMiles: useMiles,
                    fractionDigits: 2,
                  ),
                  style: GoogleFonts.spaceGrotesk(
                    color: textColor,
                    fontSize: config.size == ShareCardSize.wallpaper ? 96 : 72,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: -2,
                  ),
                ),
                Text(
                  Formatters.distanceUnitOnly(walk.distanceMeters, useMiles: useMiles),
                  style: GoogleFonts.plusJakartaSans(
                    color: subColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: aspect > 1.5 ? 32 : 20),
                Row(
                  children: [
                    if (config.showPace)
                      _MetricBlock(
                        label: 'Pace',
                        value: Formatters.paceSecPerUnit(
                          walk.avgPaceSecPerKm,
                          useMiles: useMiles,
                        ),
                        textColor: textColor,
                        subColor: subColor,
                      ),
                    if (config.showPace) const SizedBox(width: 28),
                    _MetricBlock(
                      label: 'Time',
                      value: Formatters.durationMs(walk.durationMs),
                      textColor: textColor,
                      subColor: subColor,
                    ),
                    if (config.showCalories) const SizedBox(width: 28),
                    if (config.showCalories)
                      _MetricBlock(
                        label: 'Calories',
                        value: Formatters.calories(
                          walk.caloriesKcal,
                          fractionDigits: 0,
                        ),
                        textColor: textColor,
                        subColor: subColor,
                      ),
                  ],
                ),
                if (config.showDate) ...[
                  const SizedBox(height: 24),
                  Text(
                    Formatters.dateTimeShort(walk.startedAt),
                    style: GoogleFonts.plusJakartaSans(
                      color: subColor,
                      fontSize: 16,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  AppConstants.tagline,
                  style: GoogleFonts.plusJakartaSans(
                    color: textColor.withValues(alpha: 0.6),
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricBlock extends StatelessWidget {
  const _MetricBlock({
    required this.label,
    required this.value,
    required this.textColor,
    required this.subColor,
  });

  final String label;
  final String value;
  final Color textColor;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: subColor,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _RoutePainter extends CustomPainter {
  _RoutePainter({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });

  final List<GeoPoint> points;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    var minLat = points.first.latitude;
    var maxLat = points.first.latitude;
    var minLng = points.first.longitude;
    var maxLng = points.first.longitude;

    for (final p in points) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }

    final latPad = (maxLat - minLat) * 0.15 + 0.0005;
    final lngPad = (maxLng - minLng) * 0.15 + 0.0005;
    minLat -= latPad;
    maxLat += latPad;
    minLng -= lngPad;
    maxLng += lngPad;

    Offset project(GeoPoint p) {
      final x = (p.longitude - minLng) / (maxLng - minLng);
      final y = 1 - (p.latitude - minLat) / (maxLat - minLat);
      return Offset(x * size.width, y * size.height);
    }

    final path = Path()..moveTo(project(points.first).dx, project(points.first).dy);
    for (var i = 1; i < points.length; i++) {
      final pt = project(points[i]);
      path.lineTo(pt.dx, pt.dy);
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
