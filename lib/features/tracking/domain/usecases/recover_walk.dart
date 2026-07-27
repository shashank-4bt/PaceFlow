import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';
import 'package:paceflow/features/tracking/domain/repositories/tracking_repository.dart';

class RecoverWalkUseCase {
  const RecoverWalkUseCase(this._repository);

  final TrackingRepository _repository;

  Future<WalkSession?> call() {
    return _repository.recoverWalk();
  }
}
