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

  testWidgets('delete', (WidgetTester tester) async {
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
    await tester.pumpAndSettle();
    expect(find.text("12345"), findsOneWidget);

    await tester.tap(find.byKey(Key("deleteButton")));
    await tester.pumpAndSettle();

    //assert
    expect(find.text("1234"), findsOneWidget);
  });

  testWidgets('delete', (WidgetTester tester) async {
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
    await tester.pumpAndSettle();
    expect(find.text("12345"), findsOneWidget);

    await tester.tap(find.byKey(Key("deleteButton")));
    await tester.pumpAndSettle();

    //assert
    expect(find.text("1234"), findsOneWidget);
  });

  testWidgets('dialog display - success', (WidgetTester tester) async {
    //arrange
    //mock - login service - nothing เพราะว่ายังไม่ได้ยิง api call
    when(mockLoginService.authenticate("123456"))
        .thenAnswer((_) async => AuthorizationStatus.success);
    when(mockPinRules.getErrorMessage("123456")).thenReturn(null);

    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //create login screen
    await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<LoginViewModel>(
      create: (_) =>
          LoginViewModel(mockLoginService, SortOrder.ascending, mockPinRules),
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
    // expect(find.text("123456"), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Login success"), findsOneWidget);
    // await expectLater(
    //     find.byType(MaterialApp), matchesGoldenFile('goldens/widget.png'));
  });

  testWidgets('dialog display - 401', (WidgetTester tester) async {
    //arrange
    //mock - login service - nothing เพราะว่ายังไม่ได้ยิง api call
    when(mockLoginService.authenticate("123456"))
        .thenAnswer((_) async => AuthorizationStatus.unauthorised);
    when(mockPinRules.getErrorMessage("123456")).thenReturn(null);

    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //create login screen
    await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<LoginViewModel>(
      create: (_) =>
          LoginViewModel(mockLoginService, SortOrder.ascending, mockPinRules),
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
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Unauthorised"), findsOneWidget); 
    // await expectLater(
    //     find.byType(MaterialApp), matchesGoldenFile('goldens/widget.png'));
  });

  testWidgets('dialog display - !401', (WidgetTester tester) async {
    //arrange
    //mock - login service - nothing เพราะว่ายังไม่ได้ยิง api call
    when(mockLoginService.authenticate("123456"))
        .thenAnswer((_) async => AuthorizationStatus.technicalError);
    when(mockPinRules.getErrorMessage("123456")).thenReturn(null);

    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //create login screen
    await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<LoginViewModel>(
      create: (_) =>
          LoginViewModel(mockLoginService, SortOrder.ascending, mockPinRules),
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
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Facing technical difficulties"), findsOneWidget); 
    //Facing technical difficulties
    // await expectLater(
    //     find.byType(MaterialApp), matchesGoldenFile('goldens/widget.png'));
  });

  testWidgets('dialog display - Pin rule error', (WidgetTester tester) async {
    //arrange
    //mock - login service - nothing เพราะว่ายังไม่ได้ยิง api call
    // when(mockLoginService.authenticate("123456"))
    //     .thenAnswer((_) async => AuthorizationStatus.technicalError);
    when(mockPinRules.getErrorMessage("123456")).thenReturn("Pin invalid format");

    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //create login screen
    await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<LoginViewModel>(
      create: (_) =>
          LoginViewModel(mockLoginService, SortOrder.ascending, mockPinRules),
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
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Pin invalid format"), findsOneWidget); 
    //Facing technical difficulties
    // await expectLater(
    //     find.byType(MaterialApp), matchesGoldenFile('goldens/widget.png'));
  });


  testWidgets('display dialog - v2', (WidgetTester tester) async {
    //Mock
    when(mockLoginViewModel.dialogMessage).thenReturn("Test");
    when(mockLoginViewModel.inputtedPin).thenReturn("132457");
    when(mockLoginViewModel.isLoading).thenReturn(false);
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    //Set screen size before run test
    final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));
    //Create widget
    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>.value(
            value:  mockLoginViewModel,
            child: LoginScreen(),
      )),
    );
    //Act
    await tester.pumpAndSettle();
    // //Assert
    expect(find.byType(AlertDialog), findsOneWidget);
    // await expectLater(
    //     find.byType(MaterialApp), matchesGoldenFile('goldens/widget_v2-1.png'));
  });

  testWidgets('display text - v2 - enter', (WidgetTester tester) async {
    //Mock
    when(mockLoginViewModel.dialogMessage).thenReturn("");
    when(mockLoginViewModel.inputtedPin).thenReturn("1327");
    when(mockLoginViewModel.isLoading).thenReturn(false);
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    //Set screen size before run test
    final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));
    //Create widget
    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>.value(
            value:  mockLoginViewModel,
            child: LoginScreen(),
      )),
    );
    //Act
    await tester.tap(find.text("1"));
    await tester.pumpAndSettle();
    verify(mockLoginViewModel.onDigitPressed(1,any)).called(1);
    //Assert
    // expect(find.text("132457"), findsOneWidget);
    // await expectLater(
    //     find.byType(MaterialApp), matchesGoldenFile('goldens/widget_v2-2.png'));
  });

  testWidgets('display text - v2 - delete', (WidgetTester tester) async {
    //Mock
    when(mockLoginViewModel.dialogMessage).thenReturn("");
    when(mockLoginViewModel.inputtedPin).thenReturn("132457");
    when(mockLoginViewModel.isLoading).thenReturn(false);
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);

    //Set screen size before run test
    final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));
    //Create widget
    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>.value(
            value:  mockLoginViewModel,
            child: LoginScreen(),
      )),
    );
    
    //Act
    await tester.tap(find.byKey(Key("deleteButton"))); // ต้องมี key ก่อน
    await tester.pumpAndSettle();
    //Assert
    // expect(find.text("132457"), findsOneWidget);
    verify(mockLoginViewModel.onDeleteButtonPressed()).called(1);
    // await expectLater(
    //     find.byType(MaterialApp), matchesGoldenFile('goldens/widget_v2-2.png'));
  });
}
