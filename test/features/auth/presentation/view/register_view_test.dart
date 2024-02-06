import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recyclosmart/features/auth/presentation/view/register_view.dart';

void main() {
  testWidgets('Registration view ...', (tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: MaterialApp(
        home: RegisterView(),
      ),
    ));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Aasif');

    await tester.enterText(find.byType(TextFormField).at(1), 'Manandhar');

    await tester.enterText(find.byType(TextFormField).at(2), '981234567');

    await tester.enterText(find.byType(TextFormField).at(3), 'Aasif');

    await tester.enterText(find.byType(TextFormField).at(4), 'Aasif123');

    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    // Verify UI initial State

    expect(find.byType(TextFormField), findsNWidgets(5));

    expect(find.widgetWithText(SnackBar, 'Registered successfully'),
        findsOneWidget);
  });
}
