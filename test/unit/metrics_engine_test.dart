import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/services/metrics_engine.dart';

void main() {
  GeoPoint gp({
    required double lat,
    required double lng,
    required DateTime time,
    double? altitude,
    double? speed,
  }) {
    return GeoPoint(
      latitude: lat,
      longitude: lng,
      recordedAt: time,
      altitude: altitude,
      speed: speed,
    );
  }

  group('MetricsEngine', () {
    test('accumulates distance across sequential points', () {
      final engine = MetricsEngine();
      final t0 = DateTime.utc(2026, 1, 1, 12);

      engine.addPoint(gp(lat: 0.0, lng: 0.0, time: t0));
      engine.addPoint(gp(lat: 0.001, lng: 0.0, time: t0.add(const Duration(seconds: 30))));

      final metrics = engine.currentMetrics(
        durationMs: 30000,
        pausedDurationMs: 0,
        steps: 40,
        weightKg: 70,
      );

      expect(metrics.distanceMeters, closeTo(111, 5));
      expect(metrics.pointCount, 2);
    });

    test('computes average pace from distance and duration', () {
      final engine = MetricsEngine();
      final t0 = DateTime.utc(2026, 1, 1, 12);

      engine.addPoint(gp(lat: 0.0, lng: 0.0, time: t0));
      engine.addPoint(gp(lat: 0.01, lng: 0.0, time: t0.add(const Duration(minutes: 6))));

      final metrics = engine.currentMetrics(
        durationMs: 360000,
        pausedDurationMs: 0,
        steps: 600,
        weightKg: 70,
      );

      expect(metrics.distanceMeters, greaterThan(1000));
      expect(metrics.avgPaceSecPerKm, greaterThan(0));
      expect(metrics.avgSpeedMps, greaterThan(0));
    });

    test('tracks elevation gain above threshold', () {
      final engine = MetricsEngine(elevationThresholdMeters: 3);
      final t0 = DateTime.utc(2026, 1, 1, 12);

      engine.addPoint(gp(lat: 1, lng: 1, time: t0, altitude: 100));
      engine.addPoint(gp(lat: 1.0001, lng: 1, time: t0.add(const Duration(seconds: 10)), altitude: 106));

      final metrics = engine.currentMetrics(
        durationMs: 10000,
        pausedDurationMs: 0,
        steps: 10,
        weightKg: 70,
      );

      expect(metrics.elevationGainM, closeTo(6, 0.1));
    });

    test('records max speed from point speed values', () {
      final engine = MetricsEngine();
      final t0 = DateTime.utc(2026, 1, 1, 12);

      engine.addPoint(gp(lat: 0, lng: 0, time: t0, speed: 1.2));
      engine.addPoint(gp(lat: 0.0001, lng: 0, time: t0.add(const Duration(seconds: 5)), speed: 1.8));

      final metrics = engine.currentMetrics(
        durationMs: 5000,
        pausedDurationMs: 0,
        steps: 5,
        weightKg: 70,
      );

      expect(metrics.maxSpeedMps, closeTo(1.8, 0.01));
    });

    test('restoreFromPoints skips filtered points', () {
      final engine = MetricsEngine();
      final t0 = DateTime.utc(2026, 1, 1, 12);

      engine.restoreFromPoints([
        gp(lat: 0, lng: 0, time: t0),
        GeoPoint(
          latitude: 0.01,
          longitude: 0,
          recordedAt: t0.add(const Duration(minutes: 1)),
          isFiltered: true,
        ),
        gp(lat: 0.002, lng: 0, time: t0.add(const Duration(minutes: 2))),
      ]);

      final metrics = engine.currentMetrics(
        durationMs: 120000,
        pausedDurationMs: 0,
        steps: 100,
        weightKg: 70,
      );

      expect(metrics.pointCount, 2);
    });

    test('reset clears accumulated state', () {
      final engine = MetricsEngine();
      final t0 = DateTime.utc(2026, 1, 1, 12);

      engine.addPoint(gp(lat: 0, lng: 0, time: t0));
      engine.reset();

      final metrics = engine.currentMetrics(
        durationMs: 0,
        pausedDurationMs: 0,
        steps: 0,
        weightKg: 70,
      );

      expect(metrics.distanceMeters, 0);
      expect(metrics.pointCount, 0);
    });
  });

  group('MetricsEngine.calculateCalories', () {
    test('returns zero for zero duration', () {
      expect(
        MetricsEngine.calculateCalories(
          durationMs: 0,
          paceSecPerKm: 600,
          weightKg: 70,
        ),
        0,
      );
    });

    test('returns higher calories for faster pace', () {
      final slow = MetricsEngine.calculateCalories(
        durationMs: 3600000,
        paceSecPerKm: 900,
        weightKg: 70,
      );
      final fast = MetricsEngine.calculateCalories(
        durationMs: 3600000,
        paceSecPerKm: 360,
        weightKg: 70,
      );
      expect(fast, greaterThan(slow));
    });
  });

  group('MetricsEngine.haversineMeters', () {
    test('matches GeoUtils order-of-magnitude for 1 degree latitude', () {
      final d = MetricsEngine.haversineMeters(0, 0, 1, 0);
      expect(d, closeTo(111000, 1000));
    });
  });
}
