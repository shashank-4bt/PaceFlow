import '../../../../core/utils/result.dart';
import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<UserProfile>> call({
    required String email,
    required String password,
    required String displayName,
  }) {
    return _repository.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
