import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/login_with_pin_screen_v2.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([UserService])
void main() {
  testWidgets('Login with Pin Screen', (WidgetTester tester) async {
    // create login screen
    await tester.pumpWidget(const MaterialApp(
      home: LoginWithPinScreen(),
    ));

    await expectLater(
        find.byType(LoginWithPinScreen), matchesGoldenFile('goldens/ref/login_with_pin.png'));
  });
}
