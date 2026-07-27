import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/features/tracking/presentation/widgets/stat_chip.dart';

void main() {
  testWidgets('StatChip displays label, value, and unit', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: StatChip(
              label: 'Distance',
              value: '2.41',
              unit: 'km',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Distance'), findsOneWidget);
    expect(find.textContaining('2.41'), findsOneWidget);
    expect(find.textContaining('km'), findsOneWidget);
  });

  testWidgets('StatChip omits unit span when unit is empty', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: StatChip(
              label: 'Duration',
              value: '32:15',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Duration'), findsOneWidget);
    expect(find.textContaining('32:15'), findsOneWidget);
  });

  testWidgets('StatChip renders multiple chips in a row', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatChip(label: 'Pace', value: '5:30', unit: '/km'),
              StatChip(label: 'Calories', value: '142', unit: 'kcal'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Pace'), findsOneWidget);
    expect(find.text('Calories'), findsOneWidget);
  });
}
