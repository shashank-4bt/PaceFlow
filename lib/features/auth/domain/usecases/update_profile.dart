import '../../../../core/utils/result.dart';
import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<UserProfile>> call(UserProfile profile) {
    return _repository.updateProfile(profile);
  }
}
