import 'dart:convert';

import 'package:drift/drift.dart';

import 'package:paceflow/core/database/app_database.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_metrics.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';

class WalkDto {
  const WalkDto({
    required this.id,
    required this.userId,
    required this.status,
    required this.startedAt,
    this.remoteId,
    this.title,
    this.endedAt,
    this.durationMs = 0,
    this.pausedDurationMs = 0,
    this.distanceMeters = 0,
    this.avgPaceSecPerKm = 0,
    this.avgSpeedMps = 0,
    this.maxSpeedMps = 0,
    this.caloriesKcal = 0,
    this.steps = 0,
    this.elevationGainM = 0,
    this.elevationLossM = 0,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
    this.boundsJson,
    this.polylineEncoded,
    this.pointCount = 0,
    this.syncStatus = 'pending',
    this.syncError,
    this.syncVersion = 0,
    this.createdAt,
    this.updatedAt,
    this.points = const [],
  });

  final String id;
  final String? remoteId;
  final String userId;
  final String? title;
  final String status;
  final DateTime startedAt;
  final DateTime? endedAt;
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
  final String? boundsJson;
  final String? polylineEncoded;
  final int pointCount;
  final String syncStatus;
  final String? syncError;
  final int syncVersion;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<GeoPoint> points;

  WalkMetrics get metrics => WalkMetrics(
        durationMs: durationMs,
        pausedDurationMs: pausedDurationMs,
        distanceMeters: distanceMeters,
        avgPaceSecPerKm: avgPaceSecPerKm,
        avgSpeedMps: avgSpeedMps,
        maxSpeedMps: maxSpeedMps,
        caloriesKcal: caloriesKcal,
        steps: steps,
        elevationGainM: elevationGainM,
        elevationLossM: elevationLossM,
        startLat: startLat,
        startLng: startLng,
        endLat: endLat,
        endLng: endLng,
        boundsMinLat: WalkBounds.decode(boundsJson)?.minLat,
        boundsMaxLat: WalkBounds.decode(boundsJson)?.maxLat,
        boundsMinLng: WalkBounds.decode(boundsJson)?.minLng,
        boundsMaxLng: WalkBounds.decode(boundsJson)?.maxLng,
        polylineEncoded: polylineEncoded,
        pointCount: pointCount,
      );

  WalkSession toSession({WalkSessionStatus? sessionStatus}) {
    return WalkSession(
      id: id,
      remoteId: remoteId,
      userId: userId,
      title: title,
      status: sessionStatus ?? _mapSessionStatus(status),
      startedAt: startedAt,
      endedAt: endedAt,
      metrics: metrics,
      points: points,
    );
  }

  factory WalkDto.fromWalk(Walk walk, {List<GeoPoint> points = const []}) {
    return WalkDto(
      id: walk.id,
      remoteId: walk.remoteId,
      userId: walk.userId,
      title: walk.title,
      status: walk.status,
      startedAt: DateTime.fromMillisecondsSinceEpoch(walk.startedAt),
      endedAt: walk.endedAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(walk.endedAt!),
      durationMs: walk.durationMs,
      pausedDurationMs: walk.pausedDurationMs,
      distanceMeters: walk.distanceMeters,
      avgPaceSecPerKm: walk.avgPaceSecPerKm,
      avgSpeedMps: walk.avgSpeedMps,
      maxSpeedMps: walk.maxSpeedMps,
      caloriesKcal: walk.caloriesKcal,
      steps: walk.steps,
      elevationGainM: walk.elevationGainM,
      elevationLossM: walk.elevationLossM,
      startLat: walk.startLat,
      startLng: walk.startLng,
      endLat: walk.endLat,
      endLng: walk.endLng,
      boundsJson: walk.boundsJson,
      polylineEncoded: walk.polylineEncoded,
      pointCount: walk.pointCount,
      syncStatus: walk.syncStatus,
      syncError: walk.syncError,
      syncVersion: walk.syncVersion,
      createdAt: DateTime.fromMillisecondsSinceEpoch(walk.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(walk.updatedAt),
      points: points,
    );
  }

  factory WalkDto.fromSession(WalkSession session) {
    final metrics = session.metrics;
    String? boundsJson;
    if (metrics.boundsMinLat != null &&
        metrics.boundsMaxLat != null &&
        metrics.boundsMinLng != null &&
        metrics.boundsMaxLng != null) {
      boundsJson = WalkBounds.encode(
        WalkBounds(
          minLat: metrics.boundsMinLat!,
          maxLat: metrics.boundsMaxLat!,
          minLng: metrics.boundsMinLng!,
          maxLng: metrics.boundsMaxLng!,
        ),
      );
    }

    final now = DateTime.now();
    return WalkDto(
      id: session.id,
      remoteId: session.remoteId,
      userId: session.userId,
      title: session.title,
      status: _mapDbStatus(session.status),
      startedAt: session.startedAt,
      endedAt: session.endedAt,
      durationMs: metrics.durationMs,
      pausedDurationMs: metrics.pausedDurationMs,
      distanceMeters: metrics.distanceMeters,
      avgPaceSecPerKm: metrics.avgPaceSecPerKm,
      avgSpeedMps: metrics.avgSpeedMps,
      maxSpeedMps: metrics.maxSpeedMps,
      caloriesKcal: metrics.caloriesKcal,
      steps: metrics.steps,
      elevationGainM: metrics.elevationGainM,
      elevationLossM: metrics.elevationLossM,
      startLat: metrics.startLat,
      startLng: metrics.startLng,
      endLat: metrics.endLat,
      endLng: metrics.endLng,
      boundsJson: boundsJson,
      polylineEncoded: metrics.polylineEncoded,
      pointCount: metrics.pointCount,
      syncStatus: 'pending',
      syncVersion: 0,
      createdAt: session.startedAt,
      updatedAt: now,
      points: session.points,
    );
  }

  WalksCompanion toCompanion({String? syncStatusOverride}) {
    return WalksCompanion(
      id: Value(id),
      remoteId: Value(remoteId),
      userId: Value(userId),
      title: Value(title),
      status: Value(status),
      startedAt: Value(startedAt.millisecondsSinceEpoch),
      endedAt: Value(endedAt?.millisecondsSinceEpoch),
      durationMs: Value(durationMs),
      pausedDurationMs: Value(pausedDurationMs),
      distanceMeters: Value(distanceMeters),
      avgPaceSecPerKm: Value(avgPaceSecPerKm),
      avgSpeedMps: Value(avgSpeedMps),
      maxSpeedMps: Value(maxSpeedMps),
      caloriesKcal: Value(caloriesKcal),
      steps: Value(steps),
      elevationGainM: Value(elevationGainM),
      elevationLossM: Value(elevationLossM),
      startLat: Value(startLat),
      startLng: Value(startLng),
      endLat: Value(endLat),
      endLng: Value(endLng),
      boundsJson: Value(boundsJson),
      polylineEncoded: Value(polylineEncoded),
      pointCount: Value(pointCount),
      syncStatus: Value(syncStatusOverride ?? syncStatus),
      syncError: const Value(null),
      syncVersion: Value(syncVersion),
      createdAt: Value((createdAt ?? startedAt).millisecondsSinceEpoch),
      updatedAt: Value((updatedAt ?? DateTime.now()).millisecondsSinceEpoch),
    );
  }

  Map<String, dynamic> toFirestoreMap({required String localId}) {
    final bounds = WalkBounds.decode(boundsJson);
    return {
      'id': remoteId ?? id,
      'localId': localId,
      'userId': userId,
      'title': title,
      'status': status == 'discarded' ? 'discarded' : 'completed',
      'startedAt': startedAt.toUtc(),
      'endedAt': endedAt?.toUtc(),
      'durationMs': durationMs,
      'pausedDurationMs': pausedDurationMs,
      'distanceMeters': distanceMeters,
      'avgPaceSecPerKm': avgPaceSecPerKm,
      'avgSpeedMps': avgSpeedMps,
      'maxSpeedMps': maxSpeedMps,
      'caloriesKcal': caloriesKcal,
      'steps': steps,
      'elevationGainM': elevationGainM,
      'elevationLossM': elevationLossM,
      'startLat': startLat,
      'startLng': startLng,
      'endLat': endLat,
      'endLng': endLng,
      if (bounds != null) 'bounds': bounds.toJson(),
      'polylineEncoded': polylineEncoded,
      'pointCount': pointCount,
      'syncVersion': syncVersion + 1,
      'updatedAt': DateTime.now().toUtc(),
    };
  }

  static WalkSessionStatus _mapSessionStatus(String status) {
    switch (status) {
      case 'in_progress':
        return WalkSessionStatus.active;
      case 'paused':
        return WalkSessionStatus.paused;
      case 'completed':
        return WalkSessionStatus.completed;
      default:
        return WalkSessionStatus.idle;
    }
  }

  static String _mapDbStatus(WalkSessionStatus status) {
    switch (status) {
      case WalkSessionStatus.active:
      case WalkSessionStatus.starting:
        return WalkDbStatus.inProgress.value;
      case WalkSessionStatus.paused:
        return WalkDbStatus.paused.value;
      case WalkSessionStatus.completed:
      case WalkSessionStatus.stopping:
        return WalkDbStatus.completed.value;
      case WalkSessionStatus.idle:
        return WalkDbStatus.discarded.value;
    }
  }
}

List<Map<String, dynamic>> encodePointChunk(List<GeoPoint> points) {
  return points
      .map(
        (p) => {
          't': p.recordedAt.millisecondsSinceEpoch,
          'lat': p.latitude,
          'lng': p.longitude,
          if (p.altitude != null) 'alt': p.altitude,
          if (p.accuracy != null) 'acc': p.accuracy,
          if (p.speed != null) 'spd': p.speed,
          if (p.bearing != null) 'bearing': p.bearing,
        },
      )
      .toList();
}

String encodeSyncPayload(WalkDto dto) => jsonEncode({
      'walkId': dto.id,
      'remoteId': dto.remoteId,
      'userId': dto.userId,
    });
