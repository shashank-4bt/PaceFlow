import '../../../../core/utils/result.dart';
import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<UserProfile>> call({
    required String email,
    required String password,
  }) {
    return _repository.signInWithEmail(email: email, password: password);
  }
}
