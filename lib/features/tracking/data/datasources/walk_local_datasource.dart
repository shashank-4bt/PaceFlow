import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:paceflow/core/database/app_database.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_metrics.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';

class WalkLocalDataSource {
  WalkLocalDataSource(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<WalkDto?> getActiveWalk() async {
    final walk = await _db.walksDao.getActiveWalk();
    if (walk == null) return null;
    final points = await _loadPoints(walk.id);
    return WalkDto.fromWalk(walk, points: points);
  }

  Future<WalkDto?> getWalkById(String id) async {
    final walk = await _db.walksDao.getWalkById(id);
    if (walk == null) return null;
    final points = await _loadPoints(id);
    return WalkDto.fromWalk(walk, points: points);
  }

  Future<List<WalkDto>> getWalksByUser(String userId) async {
    final walks = await _db.walksDao.getWalksByUser(userId);
    final results = <WalkDto>[];
    for (final walk in walks) {
      results.add(WalkDto.fromWalk(walk));
    }
    return results;
  }

  Stream<List<WalkDto>> watchWalksByUser(String userId, {int? limit}) {
    return _db.walksDao.watchWalksByUser(userId, limit: limit).map(
          (walks) => walks.map(WalkDto.fromWalk).toList(),
        );
  }

  Future<WalkDto> createWalk({
    required String userId,
    String? title,
    double weightKg = 70,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    final dto = WalkDto(
      id: id,
      userId: userId,
      title: title,
      status: WalkDbStatus.inProgress.value,
      startedAt: now,
      createdAt: now,
      updatedAt: now,
    );

    await _db.walksDao.insertWalk(dto.toCompanion());
    await _db.appSettingsDao.setValue('active_walk_id', id);
    await _db.appSettingsDao.setValue('user_weight_kg', weightKg.toString());
    return dto;
  }

  Future<WalkDto> updateWalk(WalkDto dto) async {
    await _db.walksDao.upsertWalk(dto.toCompanion());
    return dto;
  }

  Future<WalkDto> updateWalkMetrics(
    String walkId,
    WalkMetrics metrics, {
    required int durationMs,
    required int pausedDurationMs,
    required int steps,
  }) async {
    final existing = await getWalkById(walkId);
    if (existing == null) {
      throw StateError('Walk $walkId not found');
    }

    final updated = WalkDto(
      id: existing.id,
      remoteId: existing.remoteId,
      userId: existing.userId,
      title: existing.title,
      status: existing.status,
      startedAt: existing.startedAt,
      endedAt: existing.endedAt,
      durationMs: durationMs,
      pausedDurationMs: pausedDurationMs,
      distanceMeters: metrics.distanceMeters,
      avgPaceSecPerKm: metrics.avgPaceSecPerKm,
      avgSpeedMps: metrics.avgSpeedMps,
      maxSpeedMps: metrics.maxSpeedMps,
      caloriesKcal: metrics.caloriesKcal,
      steps: steps,
      elevationGainM: metrics.elevationGainM,
      elevationLossM: metrics.elevationLossM,
      startLat: metrics.startLat,
      startLng: metrics.startLng,
      endLat: metrics.endLat,
      endLng: metrics.endLng,
      boundsJson: metrics.boundsMinLat == null
          ? existing.boundsJson
          : WalkBounds.encode(
              WalkBounds(
                minLat: metrics.boundsMinLat!,
                maxLat: metrics.boundsMaxLat!,
                minLng: metrics.boundsMinLng!,
                maxLng: metrics.boundsMaxLng!,
              ),
            ),
      polylineEncoded: metrics.polylineEncoded,
      pointCount: metrics.pointCount,
      syncStatus: existing.syncStatus,
      syncError: existing.syncError,
      syncVersion: existing.syncVersion,
      createdAt: existing.createdAt,
      updatedAt: DateTime.now(),
      points: existing.points,
    );

    await _db.walksDao.upsertWalk(updated.toCompanion());
    return updated;
  }

  Future<void> appendPoint(String walkId, GeoPoint point) async {
    await _db.walkPointsDao.insertPoint(
      WalkPointsCompanion.insert(
        walkId: walkId,
        recordedAt: point.recordedAt.millisecondsSinceEpoch,
        lat: point.latitude,
        lng: point.longitude,
        altitude: Value(point.altitude),
        accuracy: Value(point.accuracy),
        speed: Value(point.speed),
        bearing: Value(point.bearing),
        isFiltered: Value(point.isFiltered),
      ),
    );
  }

  Future<void> appendPoints(String walkId, List<GeoPoint> points) async {
    if (points.isEmpty) return;
    await _db.walkPointsDao.insertPoints(
      points
          .map(
            (point) => WalkPointsCompanion.insert(
              walkId: walkId,
              recordedAt: point.recordedAt.millisecondsSinceEpoch,
              lat: point.latitude,
              lng: point.longitude,
              altitude: Value(point.altitude),
              accuracy: Value(point.accuracy),
              speed: Value(point.speed),
              bearing: Value(point.bearing),
              isFiltered: Value(point.isFiltered),
            ),
          )
          .toList(),
    );
  }

  Future<WalkDto> pauseWalk(String walkId) async {
    final walk = await getWalkById(walkId);
    if (walk == null) throw StateError('Walk $walkId not found');

    final pausedAt = DateTime.now();
    await _db.walkPausesDao.insertPause(
      WalkPausesCompanion.insert(
        walkId: walkId,
        pausedAt: pausedAt.millisecondsSinceEpoch,
      ),
    );

    final updated = WalkDto(
      id: walk.id,
      remoteId: walk.remoteId,
      userId: walk.userId,
      title: walk.title,
      status: WalkDbStatus.paused.value,
      startedAt: walk.startedAt,
      endedAt: walk.endedAt,
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
      createdAt: walk.createdAt,
      updatedAt: DateTime.now(),
      points: walk.points,
    );
    await _db.walksDao.upsertWalk(updated.toCompanion());
    return updated;
  }

  Future<WalkDto> resumeWalk(String walkId) async {
    final walk = await getWalkById(walkId);
    if (walk == null) throw StateError('Walk $walkId not found');

    final openPause = await _db.walkPausesDao.getOpenPause(walkId);
    if (openPause != null) {
      final resumedAt = DateTime.now().millisecondsSinceEpoch;
      final pauseDuration = resumedAt - openPause.pausedAt;
      await _db.walkPausesDao.updatePause(
        WalkPausesCompanion(
          id: Value(openPause.id),
          resumedAt: Value(resumedAt),
        ),
      );

      final updated = WalkDto(
        id: walk.id,
        remoteId: walk.remoteId,
        userId: walk.userId,
        title: walk.title,
        status: WalkDbStatus.inProgress.value,
        startedAt: walk.startedAt,
        endedAt: walk.endedAt,
        durationMs: walk.durationMs,
        pausedDurationMs: walk.pausedDurationMs + pauseDuration,
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
        createdAt: walk.createdAt,
        updatedAt: DateTime.now(),
        points: walk.points,
      );
      await _db.walksDao.upsertWalk(updated.toCompanion());
      return updated;
    }

    final updated = WalkDto(
      id: walk.id,
      remoteId: walk.remoteId,
      userId: walk.userId,
      title: walk.title,
      status: WalkDbStatus.inProgress.value,
      startedAt: walk.startedAt,
      endedAt: walk.endedAt,
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
      createdAt: walk.createdAt,
      updatedAt: DateTime.now(),
      points: walk.points,
    );
    await _db.walksDao.upsertWalk(updated.toCompanion());
    return updated;
  }

  Future<WalkDto> completeWalk(String walkId, WalkSession session) async {
    final dto = WalkDto.fromSession(
      session.copyWith(
        status: WalkSessionStatus.completed,
        endedAt: DateTime.now(),
      ),
    ).copyWithStatus(WalkDbStatus.completed.value);

    await _db.walksDao.upsertWalk(
      dto.toCompanion(syncStatusOverride: 'pending'),
    );
    await _db.appSettingsDao.setValue('active_walk_id', '');
    return dto;
  }

  Future<void> discardWalk(String walkId) async {
    final walk = await getWalkById(walkId);
    if (walk == null) return;

    final updated = walk.copyWithStatus(WalkDbStatus.discarded.value);
    await _db.walksDao.upsertWalk(updated.toCompanion());
    await _db.appSettingsDao.setValue('active_walk_id', '');
  }

  Future<void> deleteWalk(String walkId) async {
    await _db.walkPointsDao.deletePointsForWalk(walkId);
    await _db.walksDao.deleteWalk(walkId);
  }

  Future<void> enqueueSync({
    required String entityType,
    required String entityId,
    required String operation,
    String? payloadJson,
  }) async {
    await _db.syncQueueDao.enqueue(
      SyncQueueCompanion.insert(
        entityType: entityType,
        entityId: entityId,
        operation: operation,
        payloadJson: Value(payloadJson),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<List<SyncQueueData>> getPendingSyncItems({int limit = 20}) {
    return _db.syncQueueDao.getPendingItems(limit: limit);
  }

  Future<void> markSyncAttempt(
    int queueId, {
    required int attempts,
    required DateTime nextAttemptAt,
  }) {
    return _db.syncQueueDao.markAttempt(
      queueId,
      attempts: attempts,
      nextAttemptAt: nextAttemptAt.millisecondsSinceEpoch,
    );
  }

  Future<void> removeSyncItem(int queueId) {
    return _db.syncQueueDao.deleteItem(queueId);
  }

  Future<double> getUserWeightKg() async {
    final value = await _db.appSettingsDao.getValue('user_weight_kg');
    return double.tryParse(value ?? '') ?? 70;
  }

  Future<List<GeoPoint>> _loadPoints(String walkId) async {
    final rows = await _db.walkPointsDao.getPointsForWalk(walkId);
    return rows
        .map(
          (row) => GeoPoint(
            latitude: row.lat,
            longitude: row.lng,
            recordedAt: DateTime.fromMillisecondsSinceEpoch(row.recordedAt),
            altitude: row.altitude,
            accuracy: row.accuracy,
            speed: row.speed,
            bearing: row.bearing,
            isFiltered: row.isFiltered,
          ),
        )
        .toList();
  }
}

extension on WalkDto {
  WalkDto copyWithStatus(String status) {
    return WalkDto(
      id: id,
      remoteId: remoteId,
      userId: userId,
      title: title,
      status: status,
      startedAt: startedAt,
      endedAt: endedAt ?? DateTime.now(),
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
      boundsJson: boundsJson,
      polylineEncoded: polylineEncoded,
      pointCount: pointCount,
      syncStatus: syncStatus,
      syncError: syncError,
      syncVersion: syncVersion,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      points: points,
    );
  }
}
