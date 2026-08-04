import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_profile_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Stream<UserProfile?> watchAuthState() {
    return _remoteDataSource.watchAuthState().map(
          (model) => model?.toEntity(),
        );
  }

  @override
  Future<Result<UserProfile>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return _guard(() async {
      final model = await _remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Result<UserProfile>> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    return _guard(() async {
      final model = await _remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Result<UserProfile>> signInWithGoogle() async {
    return _guard(() async {
      final model = await _remoteDataSource.signInWithGoogle();
      return model.toEntity();
    });
  }

  @override
  Future<Result<void>> signOut() async {
    return _guardVoid(() => _remoteDataSource.signOut());
  }

  @override
  Future<Result<void>> sendPasswordResetEmail({required String email}) async {
    return _guardVoid(
      () => _remoteDataSource.sendPasswordResetEmail(email: email),
    );
  }

  @override
  Future<Result<UserProfile>> updateProfile(UserProfile profile) async {
    return _guard(() async {
      final model = UserProfileModel.fromEntity(profile);
      final updated = await _remoteDataSource.updateProfile(model);
      return updated.toEntity();
    });
  }

  @override
  Future<Result<void>> deleteAccount() async {
    return _guardVoid(() => _remoteDataSource.deleteAccount());
  }

  Future<Result<T>> _guard<T>(Future<T> Function() action) async {
    try {
      final value = await action();
      return Result.success(value);
    } on AppException catch (error) {
      return Result.failure(ErrorHandler.mapException(error));
    } catch (error, stackTrace) {
      return Result.failure(ErrorHandler.mapException(error, stackTrace));
    }
  }

  Future<Result<void>> _guardVoid(Future<void> Function() action) async {
    try {
      await action();
      return Result.success(null);
    } on AppException catch (error) {
      return Result.failure(ErrorHandler.mapException(error));
    } catch (error, stackTrace) {
      return Result.failure(ErrorHandler.mapException(error, stackTrace));
    }
  }
}
