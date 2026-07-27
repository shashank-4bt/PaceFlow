import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/app/theme/app_theme.dart';
import 'package:paceflow/core/di/providers.dart';
import 'package:paceflow/core/utils/result.dart';
import 'package:paceflow/features/auth/domain/entities/user_profile.dart';
import 'package:paceflow/features/auth/domain/repositories/auth_repository.dart';
import 'package:paceflow/features/auth/domain/usecases/watch_auth_state.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/auth/presentation/pages/sign_in_page.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Stream<UserProfile?> watchAuthState() => const Stream.empty();

  @override
  Future<Result<UserProfile>> signInWithEmail({
    required String email,
    required String password,
  }) =>
      throw UnimplementedError();

  @override
  Future<Result<UserProfile>> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) =>
      throw UnimplementedError();

  @override
  Future<Result<UserProfile>> signInWithGoogle() => throw UnimplementedError();

  @override
  Future<Result<void>> signOut() => throw UnimplementedError();

  @override
  Future<Result<void>> sendPasswordResetEmail({required String email}) =>
      throw UnimplementedError();

  @override
  Future<Result<UserProfile>> updateProfile(UserProfile profile) =>
      throw UnimplementedError();

  @override
  Future<Result<void>> deleteAccount() => throw UnimplementedError();
}

void main() {
  testWidgets('SignInPage renders welcome copy and form fields', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          watchAuthStateUseCaseProvider.overrideWith(
            (ref) => WatchAuthStateUseCase(_FakeAuthRepository()),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const SignInPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in to continue your walking journey.'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
  });

  testWidgets('SignInPage validates empty email on submit', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          watchAuthStateUseCaseProvider.overrideWith(
            (ref) => WatchAuthStateUseCase(_FakeAuthRepository()),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const SignInPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Email is required.'), findsOneWidget);
  });

  testWidgets('SignInPage shows loading indicator when auth is loading', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_LoadingAuthController.new),
        ],
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const SignInPage(),
        ),
      ),
    );
    // CircularProgressIndicator never "settles"; pump once for the frame.
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
  });
}

class _LoadingAuthController extends AuthController {
  @override
  AuthState build() => const AuthState(isLoading: true);
}
