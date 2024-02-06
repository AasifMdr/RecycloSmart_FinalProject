import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recyclosmart/features/auth/presentation/view/login_view.dart';

void main() {
  group('LoginView widget tests', () {
    testWidgets('LoginView displays welcome message',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      expect(find.text('Welcome back !'), findsOneWidget);
    });

    testWidgets('LoginView enters username and password',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      // Enter username
      await tester.enterText(
          find.byKey(const ValueKey('username')), 'testuser');
      expect(find.text('testuser'), findsOneWidget);

      // Enter password
      await tester.enterText(
          find.byKey(const ValueKey('password')), 'testpassword');
      expect(find.text('testpassword'), findsOneWidget);

      expect(find.text('Lost Items'), findsNothing);
    });
  });
}
