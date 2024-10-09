import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([LoginService])
void main() {
  // late MockUserService mockUserService;

  // setUp(() {
  //   mockUserService = MockUserService();
  // });

  // testWidgets('Widget Golden Test aka snapshot testing - PinEntryScreen',
  //     (WidgetTester tester) async {
  //   when(mockUserService.fetchUserDetails("132435")).thenAnswer(
  //       (_) async => {'name': 'John Doe', 'email': 'john.doe@example.com'});

  //   // Build the widget
  //   await tester.pumpWidget(
  //     MaterialApp(home: LoginWithPinScreen(userService: MockUserService())),
  //   );

  //   // Take a screenshot and compare it with a golden file
  //   await expectLater(
  //     find.byType(LoginWithPinScreen),
  //     matchesGoldenFile('goldens/ref/widget_golden_test.png'),
  //   );
  // });
}
