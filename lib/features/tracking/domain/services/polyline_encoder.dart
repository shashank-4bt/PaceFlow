import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';

/// Google encoded polyline algorithm (precision 5).
class PolylineEncoder {
  PolylineEncoder._();

  static String encode(List<GeoPoint> points) {
    if (points.isEmpty) return '';

    final buffer = StringBuffer();
    var prevLat = 0;
    var prevLng = 0;

    for (final point in points) {
      final lat = (point.latitude * 1e5).round();
      final lng = (point.longitude * 1e5).round();
      _encodeValue(buffer, lat - prevLat);
      _encodeValue(buffer, lng - prevLng);
      prevLat = lat;
      prevLng = lng;
    }

    return buffer.toString();
  }

  static List<GeoPoint> decode(String encoded) {
    final points = <GeoPoint>[];
    var index = 0;
    var lat = 0;
    var lng = 0;

    while (index < encoded.length) {
      final latResult = _decodeValue(encoded, index);
      lat += latResult.value;
      index = latResult.index;

      final lngResult = _decodeValue(encoded, index);
      lng += lngResult.value;
      index = lngResult.index;

      points.add(
        GeoPoint(
          latitude: lat / 1e5,
          longitude: lng / 1e5,
          recordedAt: DateTime.fromMillisecondsSinceEpoch(0),
        ),
      );
    }

    return points;
  }

  static void _encodeValue(StringBuffer buffer, int value) {
    var shifted = value < 0 ? ~(value << 1) : value << 1;
    while (shifted >= 0x20) {
      buffer.writeCharCode(((0x20 | (shifted & 0x1f)) + 63));
      shifted >>= 5;
    }
    buffer.writeCharCode(shifted + 63);
  }

  static _DecodeResult _decodeValue(String encoded, int index) {
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

class _DecodeResult {
  const _DecodeResult(this.value, this.index);

  final int value;
  final int index;
}
