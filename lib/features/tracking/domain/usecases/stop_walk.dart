import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';
import 'package:paceflow/features/tracking/domain/repositories/tracking_repository.dart';

class StopWalkUseCase {
  const StopWalkUseCase(this._repository);

  final TrackingRepository _repository;

  Future<WalkSession> call(String walkId) {
    return _repository.stopWalk(walkId);
  }
}
