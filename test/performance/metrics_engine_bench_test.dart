import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/services/metrics_engine.dart';

void main() {
  test('MetricsEngine processes 10k points within performance budget', () {
    final engine = MetricsEngine();
    final start = DateTime.now();
    final t0 = DateTime.utc(2026, 6, 1, 8);

    for (var i = 0; i < 10000; i++) {
      final lat = 51.5 + (i * 0.00001);
      final lng = -0.12 + (i * 0.000005);
      engine.addPoint(
        GeoPoint(
          latitude: lat,
          longitude: lng,
          recordedAt: t0.add(Duration(seconds: i)),
          speed: 1.4,
        ),
      );
    }

    final metrics = engine.currentMetrics(
      durationMs: 10000 * 1000,
      pausedDurationMs: 0,
      steps: 12000,
      weightKg: 70,
      includePolyline: false,
    );

    final elapsed = DateTime.now().difference(start);

    expect(metrics.pointCount, 10000);
    expect(metrics.distanceMeters, greaterThan(0));
    expect(
      elapsed.inMilliseconds,
      lessThan(2000),
      reason: 'Processing 10k GPS points should complete in under 2 seconds',
    );
  });
}
