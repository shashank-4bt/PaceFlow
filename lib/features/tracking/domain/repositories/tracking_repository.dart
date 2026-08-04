import 'package:paceflow/features/tracking/domain/entities/geo_point.dart';
import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';

abstract class TrackingRepository {
  Future<WalkSession?> getActiveWalk();

  Future<WalkSession?> getWalkById(String id);

  Future<List<WalkSession>> getWalksByUser(String userId);

  Future<WalkSession> startWalk({
    required String userId,
    String? title,
    double weightKg = 70,
  });

  Future<WalkSession> pauseWalk(String walkId);

  Future<WalkSession> resumeWalk(String walkId);

  Future<WalkSession> stopWalk(String walkId);

  Future<void> discardWalk(String walkId);

  Future<WalkSession?> recoverWalk();

  Future<void> appendPoint(String walkId, GeoPoint point);

  Future<void> updateLiveMetrics(WalkSession session);

  Future<void> updateSteps(String walkId, int steps);

  Future<void> enqueueSync(String walkId);
}
