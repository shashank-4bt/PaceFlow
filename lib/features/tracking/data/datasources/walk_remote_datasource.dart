import 'package:cloud_firestore/cloud_firestore.dart' hide GeoPoint;
import 'package:uuid/uuid.dart';

import 'package:paceflow/features/tracking/data/models/walk_dto.dart';
import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';

class WalkRemoteDataSource {
  WalkRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;
  static const _uuid = Uuid();
  static const chunkSize = 500;

  DocumentReference<Map<String, dynamic>> _walkDoc(String userId, String walkId) {
    return _firestore.collection('users').doc(userId).collection('walks').doc(walkId);
  }

  CollectionReference<Map<String, dynamic>> _pointChunks(
    String userId,
    String walkId,
  ) {
    return _walkDoc(userId, walkId).collection('pointChunks');
  }

  DocumentReference<Map<String, dynamic>> _lifetimeStats(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('stats')
        .doc('lifetime');
  }

  Future<String> upsertWalkWithPoints(WalkDto walk) async {
    final remoteId = walk.remoteId ?? _uuid.v4();
    final walkRef = _walkDoc(walk.userId, remoteId);
    final batch = _firestore.batch();

    batch.set(
      walkRef,
      {
        ...walk.toFirestoreMap(localId: walk.id),
        'createdAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    final acceptedPoints = walk.points.where((p) => !p.isFiltered).toList();
    final chunks = _chunkPoints(acceptedPoints);
    for (var i = 0; i < chunks.length; i++) {
      final chunkRef = _pointChunks(walk.userId, remoteId).doc('chunk_$i');
      batch.set(chunkRef, {
        'chunkIndex': i,
        'count': chunks[i].length,
        'points': encodePointChunk(chunks[i]),
      });
    }

    final statsRef = _lifetimeStats(walk.userId);
    batch.set(
      statsRef,
      {
        'totalDistanceMeters': FieldValue.increment(walk.distanceMeters),
        'totalWalks': FieldValue.increment(1),
        'totalDurationMs': FieldValue.increment(walk.durationMs),
        'totalCaloriesKcal': FieldValue.increment(walk.caloriesKcal),
        'totalSteps': FieldValue.increment(walk.steps),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    await batch.commit();
    return remoteId;
  }

  Future<void> deleteWalk(String userId, String remoteId) async {
    final walkRef = _walkDoc(userId, remoteId);
    final chunks = await _pointChunks(userId, remoteId).get();
    final batch = _firestore.batch();
    for (final doc in chunks.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(walkRef);
    await batch.commit();
  }

  List<List<GeoPoint>> _chunkPoints(List<GeoPoint> points) {
    if (points.isEmpty) return [];
    final chunks = <List<GeoPoint>>[];
    for (var i = 0; i < points.length; i += chunkSize) {
      final end = (i + chunkSize > points.length) ? points.length : i + chunkSize;
      chunks.add(points.sublist(i, end));
    }
    return chunks;
  }
}
