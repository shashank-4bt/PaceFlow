import 'dart:math' as math;

import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';

/// Filters noisy GPS readings before they affect route metrics.
class GpsFilter {
  GpsFilter({
    this.maxAccuracyMeters = 40,
    this.maxSpeedJumpMps = 8,
    this.duplicateDistanceMeters = 1.5,
  });

  final double maxAccuracyMeters;
  final double maxSpeedJumpMps;
  final double duplicateDistanceMeters;

  GeoPoint? _lastAccepted;

  void reset() {
    _lastAccepted = null;
  }

  /// Returns `null` when the point should be rejected for metrics/route use.
  GeoPoint? filter(GeoPoint point) {
    final accuracy = point.accuracy;
    if (accuracy != null && accuracy > maxAccuracyMeters) {
      return null;
    }

    final reportedSpeed = point.speed;
    if (reportedSpeed != null && reportedSpeed > maxSpeedJumpMps) {
      return null;
    }

    final previous = _lastAccepted;
    if (previous != null) {
      final distance = _haversineMeters(
        previous.latitude,
        previous.longitude,
        point.latitude,
        point.longitude,
      );

      if (distance < duplicateDistanceMeters) {
        return null;
      }

      final elapsedSec = point.recordedAt
              .difference(previous.recordedAt)
              .inMilliseconds /
          1000.0;
      if (elapsedSec > 0) {
        final impliedSpeed = distance / elapsedSec;
        if (impliedSpeed > maxSpeedJumpMps) {
          return null;
        }
      }
    }

    _lastAccepted = point;
    return point;
  }

  static double _haversineMeters(
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

  static double _toRadians(double degrees) => degrees * math.pi / 180;
}
