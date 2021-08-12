import 'package:flutter/material.dart';
import 'package:flutter_dependency_injection/counters/counter.dart';
import 'package:flutter_dependency_injection/counters/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_dependency_injection/main.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(child: MyApp()));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets(
      'Demonstrate substituting counter implementation for test purposes',
          (WidgetTester tester) async {
        // Arrange
        final mockCounterNotifier = _MockCounterNotifier();

        await tester.pumpWidget(
          ProviderScope(
              child: MyApp(),
              overrides: [
                counterNotifierProvider.overrideWithValue(mockCounterNotifier)
              ],)
        );

            // Act
            await tester.tap(find.byIcon(Icons.add));
            await tester.pump();

            // Assert
            verify(mockCounterNotifier.increment()).called(1);
  });
}

class _MockCounterNotifier extends Mock implements CounterNotifier {
  @override
  int get count => 0;
}
