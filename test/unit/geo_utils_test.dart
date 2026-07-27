import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/core/utils/geo_utils.dart';

void main() {
  group('GeoUtils.haversineDistanceMeters', () {
    test('returns zero for identical points', () {
      final distance = GeoUtils.haversineDistanceMeters(
        lat1: 51.5074,
        lng1: -0.1278,
        lat2: 51.5074,
        lng2: -0.1278,
      );
      expect(distance, closeTo(0, 0.001));
    });

    test('computes known London to Paris distance within tolerance', () {
      final distance = GeoUtils.haversineDistanceMeters(
        lat1: 51.5074,
        lng1: -0.1278,
        lat2: 48.8566,
        lng2: 2.3522,
      );
      expect(distance, closeTo(343000, 5000));
    });

    test('computes short walking segment accurately', () {
      // ~111 meters per 0.001 degree latitude at equator
      final distance = GeoUtils.haversineDistanceMeters(
        lat1: 0.0,
        lng1: 0.0,
        lat2: 0.001,
        lng2: 0.0,
      );
      expect(distance, closeTo(111.0, 2.0));
    });
  });

  group('GeoUtils.bearingDegrees', () {
    test('returns north for due north travel', () {
      final bearing = GeoUtils.bearingDegrees(
        lat1: 0.0,
        lng1: 0.0,
        lat2: 1.0,
        lng2: 0.0,
      );
      expect(bearing, closeTo(0, 1));
    });

    test('returns east for due east travel at equator', () {
      final bearing = GeoUtils.bearingDegrees(
        lat1: 0.0,
        lng1: 0.0,
        lat2: 0.0,
        lng2: 1.0,
      );
      expect(bearing, closeTo(90, 1));
    });
  });

  group('GeoUtils polyline codec', () {
    test('encode and decode round-trip preserves coordinates', () {
      const coords = [
        GeoCoordinate(latitude: 38.5, longitude: -120.2),
        GeoCoordinate(latitude: 40.7, longitude: -120.95),
        GeoCoordinate(latitude: 43.252, longitude: -126.453),
      ];

      final encoded = GeoUtils.encodePolyline(coords);
      expect(encoded, isNotEmpty);

      final decoded = GeoUtils.decodePolyline(encoded);
      expect(decoded.length, coords.length);
      for (var i = 0; i < coords.length; i++) {
        expect(decoded[i].latitude, closeTo(coords[i].latitude, 0.00001));
        expect(decoded[i].longitude, closeTo(coords[i].longitude, 0.00001));
      }
    });

    test('encode returns empty string for empty input', () {
      expect(GeoUtils.encodePolyline([]), '');
    });

    test('decode handles Google sample polyline', () {
      const encoded = '_p~iF~ps|U_ulLnnqC_mqNvxq`@';
      final decoded = GeoUtils.decodePolyline(encoded);
      expect(decoded, isNotEmpty);
      expect(decoded.first.latitude, closeTo(38.5, 0.01));
    });
  });

  group('GeoUtils bounds', () {
    test('boundsFromCoordinates computes min/max', () {
      const coords = [
        GeoCoordinate(latitude: 10, longitude: 20),
        GeoCoordinate(latitude: 15, longitude: 25),
        GeoCoordinate(latitude: 5, longitude: 18),
      ];
      final bounds = GeoUtils.boundsFromCoordinates(coords);
      expect(bounds.minLat, 5);
      expect(bounds.maxLat, 15);
      expect(bounds.minLng, 18);
      expect(bounds.maxLng, 25);
      expect(bounds.isEmpty, isFalse);
    });

    test('expandBounds adds padding', () {
      const bounds = GeoBounds(
        minLat: 0,
        maxLat: 10,
        minLng: 0,
        maxLng: 10,
      );
      final expanded = GeoUtils.expandBounds(bounds, paddingFraction: 0.1);
      expect(expanded.minLat, lessThan(bounds.minLat));
      expect(expanded.maxLat, greaterThan(bounds.maxLat));
    });

    test('empty coordinates produce empty bounds', () {
      final bounds = GeoUtils.boundsFromCoordinates([]);
      expect(bounds.isEmpty, isTrue);
    });
  });

  group('GeoUtils earth radius constant', () {
    test('uses standard WGS84 mean radius', () {
      expect(GeoUtils.earthRadiusMeters, closeTo(6371000, 1));
    });
  });
}
