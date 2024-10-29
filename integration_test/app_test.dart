import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/main.dart' as app;
void main (){
  //
  // This is E2E Test (Integration test in Flutter)
  // Require server#1 to be start first before running the test
  //
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('User journey', () {
    testWidgets('Given registered customer When login success Then landing to Home and see their profile details.', (tester) async 
    {
      //Run main app 
      app.main();
      await tester.pumpAndSettle();
      //Act 
      await tester.tap(find.text("1"));
      await tester.tap(find.text("3"));
      await tester.tap(find.text("2"));
      await tester.tap(find.text("4"));
      await tester.tap(find.text("9"));
      await tester.tap(find.text("5"));
      await tester.pumpAndSettle();
      // await Future.delayed(Duration(seconds: 3));
      //Assert
      expect(find.byKey(Key('home_screen')), findsOneWidget);
      expect(find.byKey(Key('user_profile')), findsOneWidget);
    });
  });

  testWidgets('Given unregistered customer When try to login Then error message displayed', (tester) async 
    {
      //Run main app 
      app.main();
      await tester.pumpAndSettle();
      //Act 
      await tester.tap(find.text("1"));
      await tester.tap(find.text("1"));
      await tester.tap(find.text("1"));
      await tester.tap(find.text("1"));
      await tester.tap(find.text("1"));
      await tester.tap(find.text("1"));
      await tester.pumpAndSettle();
      // await Future.delayed(Duration(seconds: 3));
      //Assert
      expect(find.byKey(Key('home_screen')), findsNothing);
      expect(find.byKey(Key('user_profile')), findsNothing);
      expect(find.byType(AlertDialog), findsOneWidget);
    });
}
