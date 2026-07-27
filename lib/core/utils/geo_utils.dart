import 'dart:math' as math;

/// Geographic coordinate and polyline utilities.
abstract final class GeoUtils {
  static const double earthRadiusMeters = 6371000.0;

  /// Haversine distance between two WGS84 points in meters.
  static double haversineDistanceMeters({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    final dLat = _toRadians(lat2 - lat1);
    final dLng = _toRadians(lng2 - lng1);
    final rLat1 = _toRadians(lat1);
    final rLat2 = _toRadians(lat2);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(rLat1) *
            math.cos(rLat2) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusMeters * c;
  }

  /// Initial bearing from point 1 to point 2 in degrees (0–360).
  static double bearingDegrees({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    final rLat1 = _toRadians(lat1);
    final rLat2 = _toRadians(lat2);
    final dLng = _toRadians(lng2 - lng1);

    final y = math.sin(dLng) * math.cos(rLat2);
    final x = math.cos(rLat1) * math.sin(rLat2) -
        math.sin(rLat1) * math.cos(rLat2) * math.cos(dLng);
    final bearing = math.atan2(y, x);
    return (_toDegrees(bearing) + 360) % 360;
  }

  /// Encodes a list of lat/lng pairs using Google's encoded polyline algorithm.
  static String encodePolyline(List<GeoCoordinate> coordinates) {
    if (coordinates.isEmpty) {
      return '';
    }

    final buffer = StringBuffer();
    var prevLat = 0;
    var prevLng = 0;

    for (final coord in coordinates) {
      final lat = (coord.latitude * 1e5).round();
      final lng = (coord.longitude * 1e5).round();
      _encodeSignedNumber(lat - prevLat, buffer);
      _encodeSignedNumber(lng - prevLng, buffer);
      prevLat = lat;
      prevLng = lng;
    }

    return buffer.toString();
  }

  /// Decodes a Google encoded polyline string into coordinates.
  static List<GeoCoordinate> decodePolyline(String encoded) {
    final coordinates = <GeoCoordinate>[];
    var index = 0;
    var lat = 0;
    var lng = 0;

    while (index < encoded.length) {
      final latResult = _decodeSignedNumber(encoded, index);
      index = latResult.nextIndex;
      lat += latResult.value;

      final lngResult = _decodeSignedNumber(encoded, index);
      index = lngResult.nextIndex;
      lng += lngResult.value;

      coordinates.add(
        GeoCoordinate(
          latitude: lat / 1e5,
          longitude: lng / 1e5,
        ),
      );
    }

    return coordinates;
  }

  /// Computes bounding box for a set of coordinates.
  static GeoBounds boundsFromCoordinates(List<GeoCoordinate> coordinates) {
    if (coordinates.isEmpty) {
      return const GeoBounds(
        minLat: 0,
        maxLat: 0,
        minLng: 0,
        maxLng: 0,
      );
    }

    var minLat = coordinates.first.latitude;
    var maxLat = coordinates.first.latitude;
    var minLng = coordinates.first.longitude;
    var maxLng = coordinates.first.longitude;

    for (final coord in coordinates.skip(1)) {
      minLat = math.min(minLat, coord.latitude);
      maxLat = math.max(maxLat, coord.latitude);
      minLng = math.min(minLng, coord.longitude);
      maxLng = math.max(maxLng, coord.longitude);
    }

    return GeoBounds(
      minLat: minLat,
      maxLat: maxLat,
      minLng: minLng,
      maxLng: maxLng,
    );
  }

  /// Expands bounds by a padding fraction (e.g. 0.1 = 10%).
  static GeoBounds expandBounds(GeoBounds bounds, {double paddingFraction = 0.1}) {
    if (bounds.isEmpty) {
      return bounds;
    }
    final latPad = (bounds.maxLat - bounds.minLat) * paddingFraction;
    final lngPad = (bounds.maxLng - bounds.minLng) * paddingFraction;
    return GeoBounds(
      minLat: bounds.minLat - latPad,
      maxLat: bounds.maxLat + latPad,
      minLng: bounds.minLng - lngPad,
      maxLng: bounds.maxLng + lngPad,
    );
  }

  static double _toRadians(double degrees) => degrees * math.pi / 180.0;

  static double _toDegrees(double radians) => radians * 180.0 / math.pi;

  static void _encodeSignedNumber(int value, StringBuffer buffer) {
    var shifted = value << 1;
    if (value < 0) {
      shifted = ~shifted;
    }
    while (shifted >= 0x20) {
      buffer.writeCharCode(((0x20 | (shifted & 0x1f)) + 63));
      shifted >>= 5;
    }
    buffer.writeCharCode(shifted + 63);
  }

  static _DecodeResult _decodeSignedNumber(String encoded, int index) {
    var result = 0;
    var shift = 0;
    var byte = 0;

    do {
      byte = encoded.codeUnitAt(index++) - 63;
      result |= (byte & 0x1f) << shift;
      shift += 5;
    } while (byte >= 0x20);

    final value = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    return _DecodeResult(value, index);
  }
}

final class GeoCoordinate {
  const GeoCoordinate({
    required this.latitude,
    required this.longitude,
    this.altitude,
  });

  final double latitude;
  final double longitude;
  final double? altitude;
}

final class GeoBounds {
  const GeoBounds({
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
  });

  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;

  bool get isEmpty => minLat == 0 && maxLat == 0 && minLng == 0 && maxLng == 0;

  double get centerLat => (minLat + maxLat) / 2;

  double get centerLng => (minLng + maxLng) / 2;

  Map<String, double> toMap() => {
        'minLat': minLat,
        'maxLat': maxLat,
        'minLng': minLng,
        'maxLng': maxLng,
      };

  factory GeoBounds.fromMap(Map<String, dynamic> map) {
    return GeoBounds(
      minLat: (map['minLat'] as num?)?.toDouble() ?? 0,
      maxLat: (map['maxLat'] as num?)?.toDouble() ?? 0,
      minLng: (map['minLng'] as num?)?.toDouble() ?? 0,
      maxLng: (map['maxLng'] as num?)?.toDouble() ?? 0,
    );
  }
}

final class _DecodeResult {
  const _DecodeResult(this.value, this.nextIndex);

  final int value;
  final int nextIndex;
}
