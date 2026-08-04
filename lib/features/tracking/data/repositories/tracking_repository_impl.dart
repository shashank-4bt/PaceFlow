import 'package:paceflow/features/tracking/data/datasources/walk_local_datasource.dart';
import 'package:paceflow/features/tracking/data/datasources/walk_remote_datasource.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';
import 'package:paceflow/features/tracking/domain/repositories/tracking_repository.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  TrackingRepositoryImpl({
    required WalkLocalDataSource local,
    required WalkRemoteDataSource remote,
  })  : _local = local,
        _remote = remote;

  final WalkLocalDataSource _local;
  final WalkRemoteDataSource _remote;

  @override
  Future<WalkSession?> getActiveWalk() async {
    final dto = await _local.getActiveWalk();
    return dto?.toSession();
  }

  @override
  Future<WalkSession?> getWalkById(String id) async {
    final dto = await _local.getWalkById(id);
    return dto?.toSession();
  }

  @override
  Future<List<WalkSession>> getWalksByUser(String userId) async {
    final walks = await _local.getWalksByUser(userId);
    return walks.map((w) => w.toSession()).toList();
  }

  @override
  Future<WalkSession> startWalk({
    required String userId,
    String? title,
    double weightKg = 70,
  }) async {
    final existing = await _local.getActiveWalk();
    if (existing != null) {
      throw StateError('An active walk already exists.');
    }

    final dto = await _local.createWalk(
      userId: userId,
      title: title,
      weightKg: weightKg,
    );
    return dto.toSession(sessionStatus: WalkSessionStatus.active);
  }

  @override
  Future<WalkSession> pauseWalk(String walkId) async {
    final dto = await _local.pauseWalk(walkId);
    return dto.toSession(sessionStatus: WalkSessionStatus.paused);
  }

  @override
  Future<WalkSession> resumeWalk(String walkId) async {
    final dto = await _local.resumeWalk(walkId);
    return dto.toSession(sessionStatus: WalkSessionStatus.active);
  }

  @override
  Future<WalkSession> stopWalk(String walkId) async {
    final dto = await _local.getWalkById(walkId);
    if (dto == null) throw StateError('Walk $walkId not found');

    final session = dto.toSession(sessionStatus: WalkSessionStatus.stopping);
    final completed = await _local.completeWalk(walkId, session);
    await enqueueSync(walkId);
    return completed.toSession(sessionStatus: WalkSessionStatus.completed);
  }

  @override
  Future<void> discardWalk(String walkId) async {
    await _local.discardWalk(walkId);
  }

  @override
  Future<WalkSession?> recoverWalk() async {
    final dto = await _local.getActiveWalk();
    if (dto == null) return null;

    final status = dto.status == WalkDbStatus.paused.value
        ? WalkSessionStatus.paused
        : WalkSessionStatus.active;

    final weightKg = await _local.getUserWeightKg();
    return dto.toSession(sessionStatus: status).copyWith(weightKg: weightKg);
  }

  @override
  Future<void> appendPoint(String walkId, GeoPoint point) {
    return _local.appendPoint(walkId, point);
  }

  @override
  Future<void> updateLiveMetrics(WalkSession session) async {
    await _local.updateWalkMetrics(
      session.id,
      session.metrics,
      durationMs: session.metrics.durationMs,
      pausedDurationMs: session.metrics.pausedDurationMs,
      steps: session.metrics.steps,
    );
  }

  @override
  Future<void> updateSteps(String walkId, int steps) async {
    final dto = await _local.getWalkById(walkId);
    if (dto == null) return;

    final updated = WalkDto(
      id: dto.id,
      remoteId: dto.remoteId,
      userId: dto.userId,
      title: dto.title,
      status: dto.status,
      startedAt: dto.startedAt,
      endedAt: dto.endedAt,
      durationMs: dto.durationMs,
      pausedDurationMs: dto.pausedDurationMs,
      distanceMeters: dto.distanceMeters,
      avgPaceSecPerKm: dto.avgPaceSecPerKm,
      avgSpeedMps: dto.avgSpeedMps,
      maxSpeedMps: dto.maxSpeedMps,
      caloriesKcal: dto.caloriesKcal,
      steps: steps,
      elevationGainM: dto.elevationGainM,
      elevationLossM: dto.elevationLossM,
      startLat: dto.startLat,
      startLng: dto.startLng,
      endLat: dto.endLat,
      endLng: dto.endLng,
      boundsJson: dto.boundsJson,
      polylineEncoded: dto.polylineEncoded,
      pointCount: dto.pointCount,
      syncStatus: dto.syncStatus,
      syncError: dto.syncError,
      syncVersion: dto.syncVersion,
      createdAt: dto.createdAt,
      updatedAt: DateTime.now(),
      points: dto.points,
    );
    await _local.updateWalk(updated);
  }

  @override
  Future<void> enqueueSync(String walkId) async {
    final dto = await _local.getWalkById(walkId);
    if (dto == null) return;

    await _local.enqueueSync(
      entityType: 'walk',
      entityId: walkId,
      operation: 'upsert',
      payloadJson: encodeSyncPayload(dto),
    );
  }

  Future<String> syncWalkToRemote(String walkId) async {
    final dto = await _local.getWalkById(walkId);
    if (dto == null) {
      throw StateError('Walk $walkId not found for sync');
    }

    final remoteId = await _remote.upsertWalkWithPoints(dto);
    final synced = WalkDto(
      id: dto.id,
      remoteId: remoteId,
      userId: dto.userId,
      title: dto.title,
      status: dto.status,
      startedAt: dto.startedAt,
      endedAt: dto.endedAt,
      durationMs: dto.durationMs,
      pausedDurationMs: dto.pausedDurationMs,
      distanceMeters: dto.distanceMeters,
      avgPaceSecPerKm: dto.avgPaceSecPerKm,
      avgSpeedMps: dto.avgSpeedMps,
      maxSpeedMps: dto.maxSpeedMps,
      caloriesKcal: dto.caloriesKcal,
      steps: dto.steps,
      elevationGainM: dto.elevationGainM,
      elevationLossM: dto.elevationLossM,
      startLat: dto.startLat,
      startLng: dto.startLng,
      endLat: dto.endLat,
      endLng: dto.endLng,
      boundsJson: dto.boundsJson,
      polylineEncoded: dto.polylineEncoded,
      pointCount: dto.pointCount,
      syncStatus: 'synced',
      syncVersion: dto.syncVersion + 1,
      createdAt: dto.createdAt,
      updatedAt: DateTime.now(),
      points: dto.points,
    );
    await _local.updateWalk(synced);
    return remoteId;
  }
}
