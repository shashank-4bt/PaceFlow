import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/features/history/presentation/pages/history_page.dart';
import 'package:paceflow/features/home/presentation/pages/dashboard_page.dart';
import 'package:paceflow/features/home/presentation/providers/home_tab_provider.dart';
import 'package:paceflow/features/profile/presentation/pages/profile_page.dart';
import 'package:paceflow/features/statistics/presentation/pages/statistics_page.dart';
import 'package:paceflow/features/tracking/presentation/pages/active_tracking_page.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  static const routePath = '/';
  static const routeName = 'home';

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  @override
  Widget build(BuildContext context) {
    final index = ref.watch(homeTabIndexProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const pages = [
      DashboardPage(),
      HistoryPage(),
      SizedBox.shrink(),
      StatisticsPage(),
      ProfilePage(),
    ];

    void onTap(int tab) {
      if (tab == 2) {
        context.push(ActiveTrackingPage.routePath);
        return;
      }
      ref.read(homeTabIndexProvider.notifier).state = tab;
    }

    return Scaffold(
      body: IndexedStack(
        index: index == 2 ? 0 : index,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.white,
          border: Border(
            top: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.06),
            ),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  selected: index == 0,
                  onTap: () => onTap(0),
                ),
                _NavItem(
                  icon: Icons.history_rounded,
                  label: 'History',
                  selected: index == 1,
                  onTap: () => onTap(1),
                ),
                _TrackFab(onTap: () => onTap(2)),
                _NavItem(
                  icon: Icons.bar_chart_rounded,
                  label: 'Stats',
                  selected: index == 3,
                  onTap: () => onTap(3),
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  selected: index == 4,
                  onTap: () => onTap(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.emerald : Theme.of(context).colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacings.borderRadiusMd,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacings.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackFab extends StatelessWidget {
  const _TrackFab({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.emerald.withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.directions_walk_rounded,
            color: AppColors.primaryBlack,
            size: 28,
          ),
        ),
      ),
    );
  }
}
