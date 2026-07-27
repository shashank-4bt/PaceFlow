import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';
import 'package:paceflow/features/tracking/domain/repositories/tracking_repository.dart';

class PauseWalkUseCase {
  const PauseWalkUseCase(this._repository);

  final TrackingRepository _repository;

  Future<WalkSession> call(String walkId) {
    return _repository.pauseWalk(walkId);
  }
}
