import 'package:paceflow/features/tracking/domain/entities/walk_session.dart';
import 'package:paceflow/features/tracking/domain/repositories/tracking_repository.dart';

class StartWalkUseCase {
  const StartWalkUseCase(this._repository);

  final TrackingRepository _repository;

  Future<WalkSession> call({
    required String userId,
    String? title,
    double weightKg = 70,
  }) {
    return _repository.startWalk(
      userId: userId,
      title: title,
      weightKg: weightKg,
    );
  }
}
