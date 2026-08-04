import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/services/gps_filter.dart';

void main() {
  GeoPoint point({
    required double lat,
    required double lng,
    required DateTime time,
    double? accuracy,
    double? speed,
  }) {
    return GeoPoint(
      latitude: lat,
      longitude: lng,
      recordedAt: time,
      accuracy: accuracy,
      speed: speed,
    );
  }

  group('GpsFilter', () {
    test('accepts first valid point', () {
      final filter = GpsFilter();
      final now = DateTime.utc(2026, 1, 1, 12);

      final result = filter.filter(
        point(lat: 51.5, lng: -0.12, time: now, accuracy: 10),
      );

      expect(result, isNotNull);
      expect(result!.latitude, 51.5);
    });

    test('rejects point with poor accuracy', () {
      final filter = GpsFilter(maxAccuracyMeters: 40);
      final now = DateTime.utc(2026, 1, 1, 12);

      final result = filter.filter(
        point(lat: 51.5, lng: -0.12, time: now, accuracy: 55),
      );

      expect(result, isNull);
    });

    test('rejects duplicate points within duplicate distance', () {
      final filter = GpsFilter(duplicateDistanceMeters: 1.5);
      final t0 = DateTime.utc(2026, 1, 1, 12);

      filter.filter(point(lat: 51.5, lng: -0.12, time: t0, accuracy: 8));
      final second = filter.filter(
        point(lat: 51.500001, lng: -0.120001, time: t0.add(const Duration(seconds: 2)), accuracy: 8),
      );

      expect(second, isNull);
    });

    test('rejects implied speed jump between points', () {
      final filter = GpsFilter(maxSpeedJumpMps: 8, duplicateDistanceMeters: 0.5);
      final t0 = DateTime.utc(2026, 1, 1, 12);

      filter.filter(point(lat: 51.5, lng: -0.12, time: t0, accuracy: 8));
      // ~100m in 1 second => ~100 m/s
      final jump = filter.filter(
        point(lat: 51.501, lng: -0.12, time: t0.add(const Duration(seconds: 1)), accuracy: 8),
      );

      expect(jump, isNull);
    });

    test('rejects reported speed above threshold', () {
      final filter = GpsFilter(maxSpeedJumpMps: 8);
      final now = DateTime.utc(2026, 1, 1, 12);

      final result = filter.filter(
        point(lat: 51.5, lng: -0.12, time: now, accuracy: 8, speed: 12),
      );

      expect(result, isNull);
    });

    test('reset clears last accepted point', () {
      final filter = GpsFilter();
      final t0 = DateTime.utc(2026, 1, 1, 12);

      filter.filter(point(lat: 51.5, lng: -0.12, time: t0, accuracy: 8));
      filter.reset();

      final again = filter.filter(
        point(lat: 51.500001, lng: -0.120001, time: t0, accuracy: 8),
      );

      expect(again, isNotNull);
    });
  });
}
