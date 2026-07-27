import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/core/constants/storage_keys.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/features/onboarding/presentation/widgets/onboarding_page_content.dart';
import 'package:paceflow/shared/widgets/pf_button.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  static const routePath = '/onboarding';
  static const routeName = 'onboarding';

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _controller = PageController();
  int _page = 0;

  static const _pages = [
    (
      icon: Icons.route_rounded,
      title: 'Track Every Step',
      subtitle: 'Precision GPS',
      description:
          'Real-time route tracking with smart filtering, live stats, and background recording so nothing gets missed.',
      gradient: AppColors.brandGradient,
    ),
    (
      icon: Icons.insights_rounded,
      title: 'See Your Progress',
      subtitle: 'Charts & Streaks',
      description:
          'Weekly insights, personal records, and achievement badges that celebrate every milestone on your journey.',
      gradient: AppColors.sunsetGradient,
    ),
    (
      icon: Icons.ios_share_rounded,
      title: 'Share Your Story',
      subtitle: 'Premium Cards',
      description:
          'Export beautiful Strava-style share cards with your route, pace, and stats — ready for social in one tap.',
      gradient: AppColors.purpleGradient,
    ),
  ];

  Future<void> _complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.onboardingCompleted, true);

    final user = ref.read(authControllerProvider).user;
    if (user != null && !user.onboardingCompleted) {
      await ref.read(authControllerProvider.notifier).updateProfile(
            user.copyWith(onboardingCompleted: true),
          );
    }

    if (mounted) context.go('/');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _complete,
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return OnboardingPageContent(
                    icon: page.icon,
                    title: page.title,
                    subtitle: page.subtitle,
                    description: page.description,
                    gradient: page.gradient,
                  );
                },
              ),
            ),
            Padding(
              padding: AppSpacings.pageInsets,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _page == i ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _page == i
                              ? AppColors.emerald
                              : AppColors.emerald.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacings.xl),
                  PfButton(
                    label: _page == _pages.length - 1 ? 'Get Started' : 'Continue',
                    onPressed: () {
                      if (_page < _pages.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutCubic,
                        );
                      } else {
                        _complete();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
