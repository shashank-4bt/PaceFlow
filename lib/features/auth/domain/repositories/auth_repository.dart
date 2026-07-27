import '../../../../core/utils/result.dart';
import '../entities/user_profile.dart';

/// Contract for authentication and profile operations.
abstract interface class AuthRepository {
  Stream<UserProfile?> watchAuthState();

  Future<Result<UserProfile>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Result<UserProfile>> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  });

  Future<Result<UserProfile>> signInWithGoogle();

  Future<Result<void>> signOut();

  Future<Result<void>> sendPasswordResetEmail({required String email});

  Future<Result<UserProfile>> updateProfile(UserProfile profile);

  Future<Result<void>> deleteAccount();
}
