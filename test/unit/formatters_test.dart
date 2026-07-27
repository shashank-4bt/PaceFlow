import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/core/utils/formatters.dart';

void main() {
  group('Formatters.distanceMeters', () {
    test('formats sub-kilometer as meters', () {
      expect(Formatters.distanceMeters(850, useMiles: false), '850 m');
    });

    test('formats kilometers with decimals', () {
      expect(Formatters.distanceMeters(2410, useMiles: false), '2.41 km');
    });

    test('formats miles when requested', () {
      expect(Formatters.distanceMeters(1609.344, useMiles: true), '1.00 mi');
    });
  });

  group('Formatters.paceSecPerUnit', () {
    test('returns placeholder for invalid pace', () {
      expect(Formatters.paceSecPerUnit(0, useMiles: false), '--:--');
      expect(Formatters.paceSecPerUnit(-1, useMiles: false), '--:--');
    });

    test('formats pace per km', () {
      expect(Formatters.paceSecPerUnit(330, useMiles: false), '05:30/km');
    });

    test('formats pace per mile', () {
      final result = Formatters.paceSecPerUnit(330, useMiles: true);
      expect(result, endsWith('/mi'));
      expect(result, isNot('--:--'));
    });
  });

  group('Formatters.durationMs', () {
    test('returns zero state', () {
      expect(Formatters.durationMs(0), '00:00');
      expect(Formatters.durationMs(0, compact: true), '0m');
    });

    test('formats mm:ss', () {
      expect(Formatters.durationMs(125000), '02:05');
    });

    test('formats hh:mm:ss when hours present', () {
      expect(Formatters.durationMs(3661000), '01:01:01');
    });

    test('compact format abbreviates units', () {
      expect(Formatters.durationMs(90000, compact: true), '1m 30s');
      expect(Formatters.durationMs(3700000, compact: true), '1h 1m');
    });
  });

  group('Formatters.calories', () {
    test('formats zero and positive values', () {
      expect(Formatters.calories(0), '0 kcal');
      expect(Formatters.calories(156.4), '156 kcal');
    });
  });

  group('Formatters.speedMps', () {
    test('formats km/h and mph', () {
      expect(Formatters.speedMps(0, useMiles: false), '0.0 km/h');
      expect(Formatters.speedMps(1, useMiles: false), '3.6 km/h');
      expect(Formatters.speedMps(1, useMiles: true), '2.2 mph');
    });
  });

  group('Formatters.steps', () {
    test('formats with locale grouping', () {
      expect(Formatters.steps(12345), contains('12'));
    });
  });

  group('Formatters.elevationMeters', () {
    test('formats meters and feet', () {
      expect(Formatters.elevationMeters(100, useMiles: false), '100 m');
      expect(Formatters.elevationMeters(100, useMiles: true), '328 ft');
    });
  });

  group('Formatters.distanceUnitOnly', () {
    test('returns correct unit labels', () {
      expect(Formatters.distanceUnitOnly(500, useMiles: false), 'm');
      expect(Formatters.distanceUnitOnly(1500, useMiles: false), 'km');
      expect(Formatters.distanceUnitOnly(1500, useMiles: true), 'mi');
    });
  });
}
