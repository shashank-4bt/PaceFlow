import 'package:equatable/equatable.dart';

class GeoPoint extends Equatable {
  const GeoPoint({
    required this.latitude,
    required this.longitude,
    required this.recordedAt,
    this.altitude,
    this.accuracy,
    this.speed,
    this.bearing,
    this.isFiltered = false,
  });

  final double latitude;
  final double longitude;
  final DateTime recordedAt;
  final double? altitude;
  final double? accuracy;
  final double? speed;
  final double? bearing;
  final bool isFiltered;

  GeoPoint copyWith({
    double? latitude,
    double? longitude,
    DateTime? recordedAt,
    double? altitude,
    double? accuracy,
    double? speed,
    double? bearing,
    bool? isFiltered,
  }) {
    return GeoPoint(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      recordedAt: recordedAt ?? this.recordedAt,
      altitude: altitude ?? this.altitude,
      accuracy: accuracy ?? this.accuracy,
      speed: speed ?? this.speed,
      bearing: bearing ?? this.bearing,
      isFiltered: isFiltered ?? this.isFiltered,
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        recordedAt,
        altitude,
        accuracy,
        speed,
        bearing,
        isFiltered,
      ];
}
