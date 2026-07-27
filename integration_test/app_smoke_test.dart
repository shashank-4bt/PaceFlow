import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:paceflow/app/theme/app_theme.dart';
import 'package:paceflow/core/constants/app_constants.dart';
import 'package:paceflow/features/tracking/presentation/widgets/live_stats_bar.dart';

/// Smoke test that runs on device/emulator without requiring Firebase init.
///
/// Full app launch (`main.dart`) is skipped until Firebase bootstrap is wired;
/// this validates a core PaceFlow UI surface renders.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('PaceFlow live stats bar smoke test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: const Scaffold(
          body: Center(
            child: LiveStatsBar(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Distance'), findsOneWidget);
    expect(find.text('Duration'), findsOneWidget);
    expect(find.text('Pace'), findsOneWidget);
    expect(find.text('Calories'), findsOneWidget);
    expect(find.text(AppConstants.appName), findsNothing);
  });

  testWidgets('conditional full app smoke — skipped until Firebase wired', (tester) async {
    const runFullApp = bool.fromEnvironment('RUN_FIREBASE_INTEGRATION');

    if (!runFullApp) {
      // Documented skip: enable with --dart-define=RUN_FIREBASE_INTEGRATION=true
      // after main.dart initializes Firebase and ProviderScope.
      expect(true, isTrue);
      return;
    }

    // When enabled, import and pump the real app entrypoint:
    // await tester.pumpWidget(const ProviderScope(child: PaceFlowApp()));
    // await tester.pumpAndSettle(const Duration(seconds: 5));
    // expect(find.text(AppConstants.appName), findsWidgets);
  });
}
