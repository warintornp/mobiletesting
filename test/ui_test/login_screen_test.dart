import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/login_screen.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'login_screen_test.mocks.dart';

//Widget testing should validate only app state changes.
//snapshot testing should validate the UI changes.
@GenerateMocks([LoginService])
void main() {
  late MockLoginService mockLoginService;

  setUp(() {
    mockLoginService = MockLoginService();
  });

  testWidgets('successful validate PIN both FE and BE',
      (WidgetTester tester) async {
    // when(mockUserService.fetchUserDetails2('132495'))
    //     .thenAnswer((_) async => null);

    when(mockLoginService.authenticate('132495')).thenAnswer((_) async => {
          'name': 'John Doe',
          'email': 'john.doe@example.com',
        });

    //Set screen size, if not will show default size which not cover the page
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //Create widget
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginViewModel(mockLoginService, SortOrder.ascending),
          child: const LoginScreen(),
        ),
      ),
    );

    //Action tap on numpad
    await tester.tap(find.text('1'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('4'));
    await tester.tap(find.text('9'));
    await tester.tap(find.text('5'));
    await tester.pumpAndSettle();

    //Assertion
    expect(find.byType(AlertDialog), findsNothing);
    verify(mockLoginService.authenticate('132495')).called(1);
  }, tags: 'widget');

  testWidgets('Invalid (FE rule) PIN with dialog', (WidgetTester tester) async {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => LoginViewModel(LoginService(), SortOrder.ascending),
        child: LoginScreen(),
      ),
    ));

    await tester.tap(find.text('1'));
    await tester.tap(find.text('1'));
    await tester.tap(find.text('1'));
    await tester.tap(find.text('1'));
    await tester.tap(find.text('1'));
    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('PIN must not have repeating digits'), findsOneWidget);
  }, tags: 'widget');

  testWidgets('Invalid (BE rule) PIN with dialog', (WidgetTester tester) async {
    when(mockLoginService.authenticate('132495')).thenAnswer((_) async => null);

    //Set screen size, if not will show default size which not cover the page
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //Create widget
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginViewModel(mockLoginService, SortOrder.ascending),
          child: const LoginScreen(),
        ),
      ),
    );

    //Action tap on numpad
    await tester.tap(find.text('1'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('4'));
    await tester.tap(find.text('9'));
    await tester.tap(find.text('5'));
    await tester.pumpAndSettle();

    //Assertion
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Invalid pin or network issue. please try again.'),
        findsOneWidget);
    verify(mockLoginService.authenticate('132495')).called(1);
  }, tags: 'widget');
}
