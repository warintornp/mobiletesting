import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mobiletesting/pages/home_screen.dart';

import 'pin_entry_screen_test.mocks.dart';

//Note: This is a widget test, can position as UI test(black-box) and integration test(white-box).
// Generate the mock for UserService
@GenerateMocks([UserService])
void main() {
  // late MockUserService mockUserService;

  // setUp(() {
  //   mockUserService = MockUserService();
  // });

  // testWidgets('PinEntryScreen test - Valid PIN and successful API call',
  //     (WidgetTester tester) async {
  //   // Set up mock response for the API call
  //   when(mockUserService.fetchUserDetails('132435')).thenAnswer(
  //       (_) async => {'name': 'John Doe', 'email': 'john.doe@example.com'});

  //   // Build the widget tree with the mock user service
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: LoginWithPinScreen(
  //           userService: mockUserService), // Pass the mock user service
  //     ),
  //   );

  //   // Verify the screen contains the PIN input field
  //   expect(find.byType(TextFormField), findsOneWidget);
  //   expect(find.text('Enter PIN'), findsOneWidget);

  //   // Enter a valid 6-digit PIN
  //   await tester.enterText(find.byType(TextFormField), '132435');
  //   await tester.pumpAndSettle();

  //   // Tap the submit button
  //   await tester.tap(find.text('Submit'));
  //   await tester.pumpAndSettle();

  //   // Verify the API call was made with the correct PIN
  //   verify(mockUserService.fetchUserDetails('132435')).called(1);

  //   // Verify navigation to the HomeScreen with user details
  //   expect(find.byType(HomeScreen), findsOneWidget);
  //   expect(find.text('Name: John Doe'), findsOneWidget);
  //   expect(find.text('Email: john.doe@example.com'), findsOneWidget);
  // });

  // testWidgets('PinEntryScreen Test - Invalid PIN should not perform API call', (
  //   WidgetTester tester,
  // ) async {
  //   // Set up mock response for the API call
  //   when(mockUserService.fetchUserDetails('123')).thenAnswer((_) async => null);

  //   await tester.pumpWidget(
  //       MaterialApp(home: LoginWithPinScreen(userService: mockUserService)));

  //   expect(find.byType(TextFormField), findsOneWidget);
  //   expect(find.text('Enter PIN'), findsOneWidget);

  //   // Enter a valid 6-digit PIN
  //   await tester.enterText(find.byType(TextFormField), '123');
  //   await tester.pumpAndSettle();

  //   // Tap the submit button
  //   await tester.tap(find.text('Submit'));
  //   await tester.pumpAndSettle();

  //   // Verify the API call should not made
  //   verifyNever(mockUserService.fetchUserDetails('123'));
  //   expect(find.byType(TextFormField), findsOneWidget);
  //   expect(find.text('PIN must be 6 digits'), findsOneWidget);
  // });

  // testWidgets(
  //     'PinEntryScreen Test - Valid PIN and successful API call but get no data',
  //     (
  //   WidgetTester tester,
  // ) async {
  //   // Set up mock response for the API call
  //   when(mockUserService.fetchUserDetails('243546'))
  //       .thenAnswer((_) async => null);

  //   await tester.pumpWidget(
  //       MaterialApp(home: LoginWithPinScreen(userService: mockUserService)));

  //   expect(find.byType(TextFormField), findsOneWidget);
  //   expect(find.text('Enter PIN'), findsOneWidget);

  //   // Enter a valid 6-digit PIN
  //   await tester.enterText(find.byType(TextFormField), '243546');
  //   await tester.pumpAndSettle();

  //   // Tap the submit button
  //   await tester.tap(find.text('Submit'));
  //   await tester.pumpAndSettle();

  //   // Verify the API call should not made
  //   verify(mockUserService.fetchUserDetails('243546')).called(1);

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Error'), findsOneWidget);
  //   expect(find.text('Failed to fetch user details.'), findsOneWidget);
  // });
}
