import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:demo_project/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('Sign up with valid credentials',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      //I tap Sign in with HTTP text
      await tester.tap(find.text('Sign in with HTTP'));
      // Trigger a frame.
      await tester.pumpAndSettle(const Duration(seconds: 2));
      //I enter email into the email input field
      await tester.enterText(find.byType(TextField).at(0), 'root');
      //I enter password into the password input field
      await tester.enterText(find.byType(TextField).at(1), 'password');
      //I tap Sign in text
      await tester.tap(find.text('Sign in'));
      // I see Successfully signed in. text
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final finder = find.byWidgetPredicate(
              (widget) => widget is RichText && widget.text.toPlainText() == "Successfully signed in.");
      expect(finder, findsOneWidget);

    });
    testWidgets('Sign up with Bad credentials',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();
          //I tap Sign in with HTTP text
          await tester.tap(find.text('Sign in with HTTP'));
          // Trigger a frame.
          await tester.pumpAndSettle(const Duration(seconds: 2));
          //I enter email into the email input field
          await tester.enterText(find.byType(TextField).at(0), 'bad');
          //I enter password into the password input field
          await tester.enterText(find.byType(TextField).at(1), 'password');
          //I tap Sign in text
          await tester.tap(find.text('Sign in'));
          await tester.pumpAndSettle(const Duration(seconds: 3));
          // I see Unable to sign in. text
          final finder = find.byWidgetPredicate(
                  (widget) => widget is RichText && widget.text.toPlainText() == "Unable to sign in.");
          expect(finder, findsOneWidget);

        });
  });
}
