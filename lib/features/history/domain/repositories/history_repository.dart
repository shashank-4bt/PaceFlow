import 'package:paceflow/features/tracking/data/models/walk_dto.dart';

abstract class HistoryRepository {
  Future<List<WalkDto>> getWalkHistory(
    String userId, {
    int? limit,
    int? offset,
  });

  Future<WalkDto?> getWalkDetail(String walkId);

  Stream<List<WalkDto>> watchWalkHistory(String userId, {int? limit});

  Future<void> syncFromRemote(String userId);
}
