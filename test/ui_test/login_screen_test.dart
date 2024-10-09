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
@GenerateMocks([UserService])
void main() {
  late MockUserService mockUserService;

  setUp(() {
    mockUserService = MockUserService();
  });

  //Need P'Ann Assist - fixed
  testWidgets('Valid PIN and successful API call with dialog',
      (WidgetTester tester) async {
    // Mock user service responses
    when(mockUserService.fetchUserDetails2('132495'))
        .thenAnswer((_) async => null);

    //Set screen size, if not will show default size which not cover the page
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //Create widget
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginViewModel(mockUserService, SortOrder.ascending),
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

    //Need P'Ann Assist - done
    expect(find.byType(AlertDialog),
        findsOneWidget); //Currently after BE validated PIN success -> we display the alert popup - need to be fix
    expect(find.text('Invalid pin or network issue. please try again.'),
        findsOneWidget);

    //Verify mock service should get call becuase FE validate passed
    verify(mockUserService.fetchUserDetails2('132495')).called(1); //Failed here
  }, tags: 'widget');

  testWidgets('Invalid (FE rule) PIN with dialog', (WidgetTester tester) async {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => LoginViewModel(UserService(), SortOrder.ascending),
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

  testWidgets(
      'Invalid (BE rule) PIN with dialog', (WidgetTester tester) async {},
      tags: 'widget');
}
