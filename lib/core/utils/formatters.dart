import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

/// Display formatters for fitness metrics with km/mi support.
abstract final class Formatters {
  static String distanceMeters(
    double meters, {
    required bool useMiles,
    int fractionDigits = 2,
  }) {
    if (useMiles) {
      final miles = meters / AppConstants.metersPerMile;
      return '${miles.toStringAsFixed(fractionDigits)} mi';
    }
    final km = meters / 1000;
    if (km < 1) {
      return '${meters.round()} m';
    }
    return '${km.toStringAsFixed(fractionDigits)} km';
  }

  static String distanceValueOnly(
    double meters, {
    required bool useMiles,
    int fractionDigits = 2,
  }) {
    if (useMiles) {
      return (meters / AppConstants.metersPerMile).toStringAsFixed(fractionDigits);
    }
    final km = meters / 1000;
    if (km < 1) {
      return meters.round().toString();
    }
    return km.toStringAsFixed(fractionDigits);
  }

  static String distanceUnitOnly(double meters, {required bool useMiles}) {
    if (useMiles) {
      return 'mi';
    }
    return meters < 1000 ? 'm' : 'km';
  }

  /// Formats pace as min:sec per km or per mile.
  static String paceSecPerUnit(
    double paceSecPerKm, {
    required bool useMiles,
  }) {
    if (paceSecPerKm <= 0 || !paceSecPerKm.isFinite) {
      return '--:--';
    }
    final secPerUnit =
        useMiles ? paceSecPerKm * AppConstants.kmPerMile : paceSecPerKm;
    final minutes = secPerUnit ~/ 60;
    final seconds = (secPerUnit % 60).round().clamp(0, 59);
    final unit = useMiles ? '/mi' : '/km';
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}$unit';
  }

  static String durationMs(int milliseconds, {bool compact = false}) {
    if (milliseconds <= 0) {
      return compact ? '0m' : '00:00';
    }
    final duration = Duration(milliseconds: milliseconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (compact) {
      if (hours > 0) {
        return '${hours}h ${minutes}m';
      }
      if (minutes > 0) {
        return '${minutes}m ${seconds}s';
      }
      return '${seconds}s';
    }

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  static String calories(double kcal, {int fractionDigits = 0}) {
    if (kcal <= 0) {
      return '0 kcal';
    }
    return '${kcal.toStringAsFixed(fractionDigits)} kcal';
  }

  static String speedMps(double mps, {required bool useMiles}) {
    if (mps <= 0) {
      return useMiles ? '0.0 mph' : '0.0 km/h';
    }
    if (useMiles) {
      final mph = mps * 2.236936;
      return '${mph.toStringAsFixed(1)} mph';
    }
    final kmh = mps * 3.6;
    return '${kmh.toStringAsFixed(1)} km/h';
  }

  static String steps(int steps) {
    return NumberFormat.decimalPattern().format(steps);
  }

  static String dateShort(DateTime dateTime) {
    return DateFormat.yMMMd().format(dateTime);
  }

  static String dateTimeShort(DateTime dateTime) {
    return DateFormat.yMMMd().add_jm().format(dateTime);
  }

  static String elevationMeters(double meters, {required bool useMiles}) {
    if (useMiles) {
      final feet = meters * 3.28084;
      return '${feet.round()} ft';
    }
    return '${meters.round()} m';
  }
}
