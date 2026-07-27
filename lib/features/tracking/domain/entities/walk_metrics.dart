import 'package:equatable/equatable.dart';

class WalkMetrics extends Equatable {
  const WalkMetrics({
    required this.durationMs,
    required this.pausedDurationMs,
    required this.distanceMeters,
    required this.avgPaceSecPerKm,
    required this.avgSpeedMps,
    required this.maxSpeedMps,
    required this.caloriesKcal,
    required this.steps,
    required this.elevationGainM,
    required this.elevationLossM,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
    this.boundsMinLat,
    this.boundsMaxLat,
    this.boundsMinLng,
    this.boundsMaxLng,
    this.polylineEncoded,
    this.pointCount = 0,
  });

  static const empty = WalkMetrics(
    durationMs: 0,
    pausedDurationMs: 0,
    distanceMeters: 0,
    avgPaceSecPerKm: 0,
    avgSpeedMps: 0,
    maxSpeedMps: 0,
    caloriesKcal: 0,
    steps: 0,
    elevationGainM: 0,
    elevationLossM: 0,
    pointCount: 0,
  );

  final int durationMs;
  final int pausedDurationMs;
  final double distanceMeters;
  final double avgPaceSecPerKm;
  final double avgSpeedMps;
  final double maxSpeedMps;
  final double caloriesKcal;
  final int steps;
  final double elevationGainM;
  final double elevationLossM;
  final double? startLat;
  final double? startLng;
  final double? endLat;
  final double? endLng;
  final double? boundsMinLat;
  final double? boundsMaxLat;
  final double? boundsMinLng;
  final double? boundsMaxLng;
  final String? polylineEncoded;
  final int pointCount;

  WalkMetrics copyWith({
    int? durationMs,
    int? pausedDurationMs,
    double? distanceMeters,
    double? avgPaceSecPerKm,
    double? avgSpeedMps,
    double? maxSpeedMps,
    double? caloriesKcal,
    int? steps,
    double? elevationGainM,
    double? elevationLossM,
    double? startLat,
    double? startLng,
    double? endLat,
    double? endLng,
    double? boundsMinLat,
    double? boundsMaxLat,
    double? boundsMinLng,
    double? boundsMaxLng,
    String? polylineEncoded,
    int? pointCount,
  }) {
    return WalkMetrics(
      durationMs: durationMs ?? this.durationMs,
      pausedDurationMs: pausedDurationMs ?? this.pausedDurationMs,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      avgPaceSecPerKm: avgPaceSecPerKm ?? this.avgPaceSecPerKm,
      avgSpeedMps: avgSpeedMps ?? this.avgSpeedMps,
      maxSpeedMps: maxSpeedMps ?? this.maxSpeedMps,
      caloriesKcal: caloriesKcal ?? this.caloriesKcal,
      steps: steps ?? this.steps,
      elevationGainM: elevationGainM ?? this.elevationGainM,
      elevationLossM: elevationLossM ?? this.elevationLossM,
      startLat: startLat ?? this.startLat,
      startLng: startLng ?? this.startLng,
      endLat: endLat ?? this.endLat,
      endLng: endLng ?? this.endLng,
      boundsMinLat: boundsMinLat ?? this.boundsMinLat,
      boundsMaxLat: boundsMaxLat ?? this.boundsMaxLat,
      boundsMinLng: boundsMinLng ?? this.boundsMinLng,
      boundsMaxLng: boundsMaxLng ?? this.boundsMaxLng,
      polylineEncoded: polylineEncoded ?? this.polylineEncoded,
      pointCount: pointCount ?? this.pointCount,
    );
  }

  @override
  List<Object?> get props => [
        durationMs,
        pausedDurationMs,
        distanceMeters,
        avgPaceSecPerKm,
        avgSpeedMps,
        maxSpeedMps,
        caloriesKcal,
        steps,
        elevationGainM,
        elevationLossM,
        startLat,
        startLng,
        endLat,
        endLng,
        boundsMinLat,
        boundsMaxLat,
        boundsMinLng,
        boundsMaxLng,
        polylineEncoded,
        pointCount,
      ];
}
