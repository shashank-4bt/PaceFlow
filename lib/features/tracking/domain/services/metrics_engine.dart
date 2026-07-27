import 'dart:math' as math;

import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_metrics.dart';
import 'package:paceflow/features/tracking/domain/services/polyline_encoder.dart';

/// Computes live walk metrics from accepted GPS points.
class MetricsEngine {
  MetricsEngine({
    this.elevationThresholdMeters = 3,
    this.defaultWeightKg = 70,
  });

  final double elevationThresholdMeters;
  final double defaultWeightKg;

  double _distanceMeters = 0;
  double _elevationGainM = 0;
  double _elevationLossM = 0;
  double _maxSpeedMps = 0;
  GeoPoint? _lastPoint;
  double? _lastAltitude;
  double? _boundsMinLat;
  double? _boundsMaxLat;
  double? _boundsMinLng;
  double? _boundsMaxLng;
  double? _startLat;
  double? _startLng;
  double? _endLat;
  double? _endLng;
  final List<GeoPoint> _acceptedPoints = [];

  void reset() {
    _distanceMeters = 0;
    _elevationGainM = 0;
    _elevationLossM = 0;
    _maxSpeedMps = 0;
    _lastPoint = null;
    _lastAltitude = null;
    _boundsMinLat = null;
    _boundsMaxLat = null;
    _boundsMinLng = null;
    _boundsMaxLng = null;
    _startLat = null;
    _startLng = null;
    _endLat = null;
    _endLng = null;
    _acceptedPoints.clear();
  }

  void restoreFromPoints(List<GeoPoint> points) {
    reset();
    for (final point in points) {
      if (point.isFiltered) continue;
      _applyPoint(point);
    }
  }

  WalkMetrics addPoint(GeoPoint point) {
    _applyPoint(point);
    return currentMetrics(
      durationMs: 0,
      pausedDurationMs: 0,
      steps: 0,
      weightKg: defaultWeightKg,
      includePolyline: false,
    );
  }

  WalkMetrics currentMetrics({
    required int durationMs,
    required int pausedDurationMs,
    required int steps,
    required double weightKg,
    bool includePolyline = true,
  }) {
    final activeDurationMs = math.max(0, durationMs - pausedDurationMs);
    final avgSpeedMps = activeDurationMs > 0
        ? _distanceMeters / (activeDurationMs / 1000)
        : 0.0;
    final avgPaceSecPerKm = _distanceMeters > 0
        ? (activeDurationMs / 1000) / (_distanceMeters / 1000)
        : 0.0;

    return WalkMetrics(
      durationMs: durationMs,
      pausedDurationMs: pausedDurationMs,
      distanceMeters: _distanceMeters,
      avgPaceSecPerKm: avgPaceSecPerKm,
      avgSpeedMps: avgSpeedMps,
      maxSpeedMps: _maxSpeedMps,
      caloriesKcal: calculateCalories(
        durationMs: activeDurationMs,
        paceSecPerKm: avgPaceSecPerKm,
        weightKg: weightKg,
      ),
      steps: steps,
      elevationGainM: _elevationGainM,
      elevationLossM: _elevationLossM,
      startLat: _startLat,
      startLng: _startLng,
      endLat: _endLat,
      endLng: _endLng,
      boundsMinLat: _boundsMinLat,
      boundsMaxLat: _boundsMaxLat,
      boundsMinLng: _boundsMinLng,
      boundsMaxLng: _boundsMaxLng,
      polylineEncoded: includePolyline && _acceptedPoints.isNotEmpty
          ? PolylineEncoder.encode(_acceptedPoints)
          : null,
      pointCount: _acceptedPoints.length,
    );
  }

  void _applyPoint(GeoPoint point) {
    _updateBounds(point.latitude, point.longitude);
    _startLat ??= point.latitude;
    _startLng ??= point.longitude;
    _endLat = point.latitude;
    _endLng = point.longitude;

    final previous = _lastPoint;
    if (previous != null) {
      _distanceMeters += haversineMeters(
        previous.latitude,
        previous.longitude,
        point.latitude,
        point.longitude,
      );
    }

    final speed = point.speed;
    if (speed != null && speed > _maxSpeedMps) {
      _maxSpeedMps = speed;
    }

    final altitude = point.altitude;
    if (altitude != null) {
      final lastAlt = _lastAltitude;
      if (lastAlt != null) {
        final delta = altitude - lastAlt;
        if (delta.abs() >= elevationThresholdMeters) {
          if (delta > 0) {
            _elevationGainM += delta;
          } else {
            _elevationLossM += delta.abs();
          }
          _lastAltitude = altitude;
        }
      } else {
        _lastAltitude = altitude;
      }
    }

    _lastPoint = point;
    _acceptedPoints.add(point);
  }

  static double haversineMeters(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const earthRadius = 6371000.0;
    final dLat = _toRadians(lat2 - lat1);
    final dLng = _toRadians(lng2 - lng1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  static double calculateCalories({
    required int durationMs,
    required double paceSecPerKm,
    required double weightKg,
  }) {
    if (durationMs <= 0) return 0;

    final paceMinPerKm = paceSecPerKm / 60;
    final met = paceMinPerKm == 0
        ? 2.8
        : paceMinPerKm > 16
            ? 2.8
            : paceMinPerKm >= 12
                ? 3.5
                : paceMinPerKm >= 10
                    ? 4.3
                    : 5.0;

    final hours = durationMs / 3600000;
    return met * weightKg * hours;
  }

  void _updateBounds(double lat, double lng) {
    _boundsMinLat =
        _boundsMinLat == null ? lat : math.min(_boundsMinLat!, lat);
    _boundsMaxLat =
        _boundsMaxLat == null ? lat : math.max(_boundsMaxLat!, lat);
    _boundsMinLng =
        _boundsMinLng == null ? lng : math.min(_boundsMinLng!, lng);
    _boundsMaxLng =
        _boundsMaxLng == null ? lng : math.max(_boundsMaxLng!, lng);
  }

  static double _toRadians(double degrees) => degrees * math.pi / 180;
}
