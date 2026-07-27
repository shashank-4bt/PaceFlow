import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../domain/entities/user_profile.dart';

/// UI state for authentication flows.
class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
    this.passwordResetSent = false,
  });

  final UserProfile? user;
  final bool isLoading;
  final String? errorMessage;
  final bool passwordResetSent;

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    UserProfile? user,
    bool? isLoading,
    String? errorMessage,
    bool? passwordResetSent,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      passwordResetSent: passwordResetSent ?? this.passwordResetSent,
    );
  }
}

class AuthController extends Notifier<AuthState> {
  StreamSubscription<UserProfile?>? _authSubscription;

  @override
  AuthState build() {
    _listenToAuthState();
    ref.onDispose(() {
      _authSubscription?.cancel();
    });
    return const AuthState();
  }

  void _listenToAuthState() {
    _authSubscription?.cancel();
    final watchAuthState = ref.read(watchAuthStateUseCaseProvider);
    _authSubscription = watchAuthState().listen(
      (user) {
        state = state.copyWith(user: user, clearError: true, isLoading: false);
        if (user != null) {
          ref.read(analyticsServiceProvider).setUserId(user.uid);
          ref.read(crashReportingServiceProvider).setUserId(user.uid);
        }
      },
      onError: (Object error) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
      },
    );
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(signInUseCaseProvider)(
      email: email,
      password: password,
    );
    return result.fold(
      onSuccess: (user) {
        state = state.copyWith(user: user, isLoading: false);
        return true;
      },
      onFailure: (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(signUpUseCaseProvider)(
      email: email,
      password: password,
      displayName: displayName,
    );
    return result.fold(
      onSuccess: (user) {
        state = state.copyWith(user: user, isLoading: false);
        ref.read(analyticsServiceProvider).logSignUp(method: 'email');
        return true;
      },
      onFailure: (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(signInGoogleUseCaseProvider)();
    return result.fold(
      onSuccess: (user) {
        state = state.copyWith(user: user, isLoading: false);
        ref.read(analyticsServiceProvider).logLogin(method: 'google');
        return true;
      },
      onFailure: (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  Future<bool> signOut() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(signOutUseCaseProvider)();
    return result.fold(
      onSuccess: (_) {
        state = const AuthState();
        ref.read(analyticsServiceProvider).setUserId(null);
        return true;
      },
      onFailure: (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  Future<bool> sendPasswordReset({required String email}) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      passwordResetSent: false,
    );
    final result = await ref.read(forgotPasswordUseCaseProvider)(email: email);
    return result.fold(
      onSuccess: (_) {
        state = state.copyWith(isLoading: false, passwordResetSent: true);
        return true;
      },
      onFailure: (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  Future<bool> updateProfile(UserProfile profile) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(updateProfileUseCaseProvider)(profile);
    return result.fold(
      onSuccess: (user) {
        state = state.copyWith(user: user, isLoading: false);
        return true;
      },
      onFailure: (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  Future<bool> deleteAccount() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(deleteAccountUseCaseProvider)();
    return result.fold(
      onSuccess: (_) {
        state = const AuthState();
        ref.read(analyticsServiceProvider).setUserId(null);
        return true;
      },
      onFailure: (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
