import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recyclosmart/features/auth/presentation/view/dashboard_view.dart';
import 'package:recyclosmart/features/auth/presentation/view/home_view.dart';
import 'package:recyclosmart/features/auth/presentation/view/profile_view.dart';

void main() {
  group('DashboardPage Widget Test', () {
    testWidgets('DashboardPage should render correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

      // Verify if the widgets are rendered correctly
      expect(find.byType(HomeView), findsOneWidget);
      expect(find.byType(ProfileView), findsNothing);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('DashboardPage bottom navigation should work correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

      // Tap on the second item in the bottom navigation bar
      await tester.tap(find.byIcon(Icons.person));
      await tester.pump();

      // Verify if the correct widget is displayed after tapping the second item
      expect(find.byType(HomeView), findsNothing);
      expect(find.byType(ProfileView), findsOneWidget);
    });

    // Add more tests for specific functionality
  });
}
