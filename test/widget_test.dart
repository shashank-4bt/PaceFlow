import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/app/theme/app_theme.dart';
import 'package:paceflow/core/constants/app_constants.dart';
import 'package:paceflow/features/tracking/presentation/widgets/live_stats_bar.dart';

void main() {
  testWidgets('PaceFlow brand smoke — live stats bar renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          backgroundColor: AppTheme.dark.scaffoldBackgroundColor,
          appBar: AppBar(title: const Text(AppConstants.appName)),
          body: const Center(child: LiveStatsBar()),
        ),
      ),
    );

    expect(find.text(AppConstants.appName), findsOneWidget);
    expect(find.text('Distance'), findsOneWidget);
    expect(find.text('Duration'), findsOneWidget);
    expect(find.text('Pace'), findsOneWidget);
    expect(find.text('Calories'), findsOneWidget);
  });
}
