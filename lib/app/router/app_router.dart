import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:paceflow/core/constants/storage_keys.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:paceflow/features/auth/presentation/pages/sign_in_page.dart';
import 'package:paceflow/features/auth/presentation/pages/sign_up_page.dart';
import 'package:paceflow/features/history/presentation/pages/walk_detail_page.dart';
import 'package:paceflow/features/home/presentation/pages/home_shell.dart';
import 'package:paceflow/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:paceflow/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:paceflow/features/settings/presentation/pages/export_data_page.dart';
import 'package:paceflow/features/settings/presentation/pages/settings_page.dart';
import 'package:paceflow/features/sharing/presentation/pages/share_studio_page.dart';
import 'package:paceflow/features/tracking/presentation/pages/active_tracking_page.dart';

final _routerRefreshNotifierProvider = Provider<ValueNotifier<int>>((ref) {
  final notifier = ValueNotifier(0);
  ref.listen(authControllerProvider, (_, __) => notifier.value++);
  ref.onDispose(notifier.dispose);
  return notifier;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final refresh = ref.watch(_routerRefreshNotifierProvider);

  return GoRouter(
    initialLocation: HomeShell.routePath,
    debugLogDiagnostics: false,
    refreshListenable: refresh,
    redirect: (context, state) async {
      final isAuthenticated = authState.isAuthenticated;
      final location = state.matchedLocation;
      final isAuthRoute = location.startsWith('/auth');

      if (!isAuthenticated) {
        return isAuthRoute ? null : SignInPage.routePath;
      }

      if (isAuthRoute) {
        return HomeShell.routePath;
      }

      final prefs = await SharedPreferences.getInstance();
      final onboardingLocal =
          prefs.getBool(StorageKeys.onboardingCompleted) ?? false;
      final onboardingProfile =
          authState.user?.onboardingCompleted ?? false;
      final onboardingDone = onboardingLocal || onboardingProfile;

      if (!onboardingDone && location != OnboardingPage.routePath) {
        return OnboardingPage.routePath;
      }

      if (onboardingDone && location == OnboardingPage.routePath) {
        return HomeShell.routePath;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: HomeShell.routePath,
        name: HomeShell.routeName,
        builder: (_, __) => const HomeShell(),
      ),
      GoRoute(
        path: OnboardingPage.routePath,
        name: OnboardingPage.routeName,
        builder: (_, __) => const OnboardingPage(),
      ),
      GoRoute(
        path: SignInPage.routePath,
        name: SignInPage.routeName,
        builder: (_, __) => const SignInPage(),
      ),
      GoRoute(
        path: SignUpPage.routePath,
        name: SignUpPage.routeName,
        builder: (_, __) => const SignUpPage(),
      ),
      GoRoute(
        path: ForgotPasswordPage.routePath,
        name: ForgotPasswordPage.routeName,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: ActiveTrackingPage.routePath,
        name: ActiveTrackingPage.routeName,
        builder: (_, __) => const ActiveTrackingPage(),
      ),
      GoRoute(
        path: '/walk/:id',
        name: WalkDetailPage.routeName,
        builder: (_, state) => WalkDetailPage(
          walkId: state.pathParameters['id']!,
        ),
        routes: [
          GoRoute(
            path: 'share',
            name: ShareStudioPage.routeName,
            builder: (_, state) => ShareStudioPage(
              walkId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: SettingsPage.routePath,
        name: SettingsPage.routeName,
        builder: (_, __) => const SettingsPage(),
      ),
      GoRoute(
        path: ExportDataPage.routePath,
        name: ExportDataPage.routeName,
        builder: (_, __) => const ExportDataPage(),
      ),
      GoRoute(
        path: EditProfilePage.routePath,
        name: EditProfilePage.routeName,
        builder: (_, __) => const EditProfilePage(),
      ),
    ],
  );
});
