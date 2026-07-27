import 'package:cloud_firestore/cloud_firestore.dart' hide GeoPoint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paceflow/core/di/providers.dart';
import 'package:paceflow/features/history/domain/repositories/history_repository.dart';
import 'package:paceflow/features/tracking/data/datasources/walk_local_datasource.dart';
import 'package:paceflow/features/tracking/data/models/walk_dto.dart';
import 'package:paceflow/features/tracking/data/providers/tracking_providers.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl({
    required WalkLocalDataSource local,
    required FirebaseFirestore firestore,
  })  : _local = local,
        _firestore = firestore;

  final WalkLocalDataSource _local;
  final FirebaseFirestore _firestore;

  @override
  Future<List<WalkDto>> getWalkHistory(
    String userId, {
    int? limit,
    int? offset,
  }) async {
    final localWalks = await _local.getWalksByUser(userId);
    final completed = localWalks
        .where((w) => w.status == 'completed')
        .toList()
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));

    if (limit == null) return completed;
    final start = offset ?? 0;
    final end = (start + limit).clamp(0, completed.length);
    if (start >= completed.length) return [];
    return completed.sublist(start, end);
  }

  @override
  Future<WalkDto?> getWalkDetail(String walkId) async {
    return _local.getWalkById(walkId);
  }

  @override
  Stream<List<WalkDto>> watchWalkHistory(String userId, {int? limit}) {
    return _local.watchWalksByUser(userId, limit: limit).map((walks) {
      final completed = walks.where((w) => w.status == 'completed').toList()
        ..sort((a, b) => b.startedAt.compareTo(a.startedAt));
      if (limit == null) return completed;
      return completed.take(limit).toList();
    });
  }

  @override
  Future<void> syncFromRemote(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('walks')
        .where('status', isEqualTo: 'completed')
        .orderBy('startedAt', descending: true)
        .limit(50)
        .get();

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final localId = data['localId'] as String? ?? doc.id;
      final existing = await _local.getWalkById(localId);
      if (existing != null && existing.syncStatus == 'synced') continue;

      final startedAt = (data['startedAt'] as Timestamp?)?.toDate();
      if (startedAt == null) continue;

      final endedAt = (data['endedAt'] as Timestamp?)?.toDate();
      final points = await _fetchPoints(userId, doc.id);

      final dto = WalkDto(
        id: localId,
        remoteId: doc.id,
        userId: userId,
        title: data['title'] as String?,
        status: 'completed',
        startedAt: startedAt,
        endedAt: endedAt,
        durationMs: (data['durationMs'] as num?)?.toInt() ?? 0,
        pausedDurationMs: (data['pausedDurationMs'] as num?)?.toInt() ?? 0,
        distanceMeters: (data['distanceMeters'] as num?)?.toDouble() ?? 0,
        avgPaceSecPerKm: (data['avgPaceSecPerKm'] as num?)?.toDouble() ?? 0,
        avgSpeedMps: (data['avgSpeedMps'] as num?)?.toDouble() ?? 0,
        maxSpeedMps: (data['maxSpeedMps'] as num?)?.toDouble() ?? 0,
        caloriesKcal: (data['caloriesKcal'] as num?)?.toDouble() ?? 0,
        steps: (data['steps'] as num?)?.toInt() ?? 0,
        elevationGainM: (data['elevationGainM'] as num?)?.toDouble() ?? 0,
        elevationLossM: (data['elevationLossM'] as num?)?.toDouble() ?? 0,
        startLat: (data['startLat'] as num?)?.toDouble(),
        startLng: (data['startLng'] as num?)?.toDouble(),
        endLat: (data['endLat'] as num?)?.toDouble(),
        endLng: (data['endLng'] as num?)?.toDouble(),
        polylineEncoded: data['polylineEncoded'] as String?,
        pointCount: (data['pointCount'] as num?)?.toInt() ?? points.length,
        syncStatus: 'synced',
        syncVersion: (data['syncVersion'] as num?)?.toInt() ?? 1,
        createdAt: startedAt,
        updatedAt: DateTime.now(),
        points: points,
      );

      await _local.updateWalk(dto);
      if (points.isNotEmpty) {
        await _local.appendPoints(localId, points);
      }
    }
  }

  Future<List<GeoPoint>> _fetchPoints(String userId, String walkId) async {
    final chunks = await _firestore
        .collection('users')
        .doc(userId)
        .collection('walks')
        .doc(walkId)
        .collection('pointChunks')
        .orderBy('chunkIndex')
        .get();

    final points = <GeoPoint>[];
    for (final chunk in chunks.docs) {
      final rawPoints = chunk.data()['points'] as List<dynamic>? ?? [];
      for (final p in rawPoints) {
        final map = p as Map<String, dynamic>;
        points.add(
          GeoPoint(
            latitude: (map['lat'] as num).toDouble(),
            longitude: (map['lng'] as num).toDouble(),
            recordedAt: DateTime.fromMillisecondsSinceEpoch(
              (map['t'] as num).toInt(),
            ),
            altitude: (map['alt'] as num?)?.toDouble(),
            accuracy: (map['acc'] as num?)?.toDouble(),
            speed: (map['spd'] as num?)?.toDouble(),
            bearing: (map['bearing'] as num?)?.toDouble(),
          ),
        );
      }
    }
    return points;
  }
}

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(
    local: ref.watch(walkLocalDataSourceProvider),
    firestore: ref.watch(firebaseFirestoreProvider),
  );
});
