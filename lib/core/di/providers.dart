import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/auth/domain/entities/user_profile.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/delete_account.dart';
import '../../features/auth/domain/usecases/forgot_password.dart';
import '../../features/auth/domain/usecases/sign_in.dart';
import '../../features/auth/domain/usecases/sign_in_google.dart';
import '../../features/auth/domain/usecases/sign_out.dart';
import '../../features/auth/domain/usecases/sign_up.dart';
import '../../features/auth/domain/usecases/update_profile.dart';
import '../../features/auth/domain/usecases/watch_auth_state.dart';
import '../constants/app_constants.dart';
import '../services/analytics_service.dart';
import '../services/crash_reporting_service.dart';
import '../services/secure_storage_service.dart';

// ── Firebase SDK providers ────────────────────────────────────────────────────

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    scopes: const ['email', 'profile'],
  );
});

// ── Core service providers ────────────────────────────────────────────────────

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

final crashReportingServiceProvider = Provider<CrashReportingService>((ref) {
  return CrashReportingService();
});

// ── Auth data layer ───────────────────────────────────────────────────────────

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider),
    firebaseStorage: ref.watch(firebaseStorageProvider),
    googleSignIn: ref.watch(googleSignInProvider),
    secureStorage: ref.watch(secureStorageServiceProvider),
    analyticsService: ref.watch(analyticsServiceProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
  );
});

// ── Auth use case providers ───────────────────────────────────────────────────

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
});

final signInGoogleUseCaseProvider = Provider<SignInGoogleUseCase>((ref) {
  return SignInGoogleUseCase(ref.watch(authRepositoryProvider));
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
});

final forgotPasswordUseCaseProvider = Provider<ForgotPasswordUseCase>((ref) {
  return ForgotPasswordUseCase(ref.watch(authRepositoryProvider));
});

final deleteAccountUseCaseProvider = Provider<DeleteAccountUseCase>((ref) {
  return DeleteAccountUseCase(ref.watch(authRepositoryProvider));
});

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  return UpdateProfileUseCase(ref.watch(authRepositoryProvider));
});

final watchAuthStateUseCaseProvider = Provider<WatchAuthStateUseCase>((ref) {
  return WatchAuthStateUseCase(ref.watch(authRepositoryProvider));
});

// ── Auth state stream ─────────────────────────────────────────────────────────

final authStateProvider = StreamProvider<UserProfile?>((ref) {
  return ref.watch(watchAuthStateUseCaseProvider)();
});

// ── App metadata ──────────────────────────────────────────────────────────────

final appMetadataProvider = Provider((ref) {
  return (
    name: AppConstants.appName,
    tagline: AppConstants.tagline,
    version: AppConstants.appVersion,
    buildNumber: AppConstants.buildNumber,
  );
});
