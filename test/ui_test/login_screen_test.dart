import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/login_screen/authorization_status.dart';
import 'package:mobiletesting/login_screen/login_screen.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([BuildContext, LoginService, PinRules, LoginViewModel])
void main() {
  late MockLoginService mockLoginService;
  late MockPinRules mockPinRules;
  late MockLoginViewModel mockLoginViewModel;

  // setUpAll(() async {
  //   await loadAppFonts();
  // });

  setUp(() {
    mockLoginService = MockLoginService();
    mockPinRules = MockPinRules();
    mockLoginViewModel = MockLoginViewModel();
  });

  testWidgets('example of widget testing', (WidgetTester tester) async {
    // Arrange
    // when(serverA.functionB('')).thenAnswer((_) async => true);
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding
        .setSurfaceSize(Size(400, 800)); // ensure a must UI component visible
    await tester.pumpWidget(
      MaterialApp(home: Text("1")),
    );

    //Act
    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    //Assertion
    expect(find.byType(AlertDialog), findsNothing);
    // verify(serverA.functionB('')).called(1);
    // await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/widget.png'));
  }, tags: 'widget');

  testWidgets('success', (WidgetTester tester) async {
    //arrange
    //mock - login service - nothing เพราะว่ายังไม่ได้ยิง api call

    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //create login screen
    await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<LoginViewModel>(
      create: (_) =>
          LoginViewModel(mockLoginService, SortOrder.ascending, PinRules()),
      child: LoginScreen(),
    )));
    // //act
    await tester.tap(find.text("1"));
    await tester.tap(find.text("2"));
    await tester.tap(find.text("3"));
    await tester.tap(find.text("4"));
    await tester.tap(find.text("5"));
    await tester.tap(find.text("6"));
    await tester.pumpAndSettle();

    //assert
    expect(find.text("123456"), findsOneWidget);
  });

}
