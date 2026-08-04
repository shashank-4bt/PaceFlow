import 'package:paceflow/features/tracking/domain/repositories/tracking_repository.dart';

class DiscardWalkUseCase {
  const DiscardWalkUseCase(this._repository);

  final TrackingRepository _repository;

  Future<void> call(String walkId) {
    return _repository.discardWalk(walkId);
  }
}
