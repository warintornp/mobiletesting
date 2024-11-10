import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

@GenerateMocks([BuildContext, LoginViewModel, LoginService, PinRules])
void main() {
  late MockLoginViewModel mockLoginViewModel;
  late MockLoginService mockLoginService;
  late MockPinRules mockPinRules;

  setUp(() {
    mockLoginViewModel = MockLoginViewModel();
    mockLoginService = MockLoginService();
    mockPinRules = MockPinRules();
  });


  testWidgets('when tap on pin digit then OnDigitPressed should get called ',
      (WidgetTester tester) async {
    //Mock
    when(mockLoginViewModel.dialogMessage).thenReturn("");
    when(mockLoginViewModel.inputtedPin).thenReturn("12345");
    when(mockLoginViewModel.isLoading).thenReturn(false);
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginViewModel.shouldNavigateToHome).thenReturn(false);

    //Set screen size before run test
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //Create widget
    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>(
        create: (_) => mockLoginViewModel,
        child: LoginScreen(),
      )),
    );

    //Act
    await tester.tap(find.text("1"));
    await tester.pumpAndSettle();

    //Assert
    verify(mockLoginViewModel.onDigitPressed(1, any)).called(1);
  });

  testWidgets(
      'when tap on delete button then onDeleteButtonPressed should get called ',
      (WidgetTester tester) async {
    //Mock
    when(mockLoginViewModel.dialogMessage).thenReturn("");
    when(mockLoginViewModel.inputtedPin).thenReturn("12345");
    when(mockLoginViewModel.isLoading).thenReturn(false);
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginViewModel.shouldNavigateToHome).thenReturn(false);

    //Set screen size before run test
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //Create widget
    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>(
        create: (_) => mockLoginViewModel,
        child: LoginScreen(),
      )),
    );

    //Act
    await tester.tap(find.byKey(Key("delete_button")));
    await tester.pumpAndSettle();

    //Assert
    verify(mockLoginViewModel.onDeleteButtonPressed()).called(1);
  });

  testWidgets(
      'when pin is valid and dialog message is not null then dialog displayed',
      (WidgetTester tester) async {
    //Mock
    when(mockLoginViewModel.dialogMessage).thenReturn("Login Success");
    when(mockLoginViewModel.inputtedPin).thenReturn("123456");
    when(mockLoginViewModel.isLoading).thenReturn(false);
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginViewModel.shouldNavigateToHome).thenReturn(false);

    //Set screen size before run test
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //Create widget
    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>(
        create: (_) => mockLoginViewModel,
        child: LoginScreen(),
      )),
    );

    //Act
    await tester.pumpAndSettle();

    //Assert
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  ////////////////////// VERION INTEGRATION /////////////////////////////testWidgets('when enter pin 6 digits then inputted pin dispalyed',
  testWidgets('when enter pin 6 digits then inputted pin dispalyed',
      (WidgetTester tester) async {
    //Mock

    //Set screen size before run test
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //Create widget
    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>(
        create: (_) =>
            LoginViewModel(mockLoginService, SortOrder.ascending, PinRules()),
        child: LoginScreen(),
      )),
    );

    //Act
    await tester.tap(find.text("1"));
    await tester.tap(find.text("2"));
    await tester.tap(find.text("3"));
    await tester.tap(find.text("4"));
    await tester.tap(find.text("5"));
    await tester.tap(find.text("6"));
    await tester.pumpAndSettle();

    //Assert
    expect(find.text("123456"), findsOneWidget);
  });

  testWidgets(
      'when enter pin 5 digits and tap delete then last inputted pin should be removed',
      (WidgetTester tester) async {
    //arrange
    //Set screen size before run test
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

    await tester.tap(find.byKey(Key("delete_button")));
    await tester.pumpAndSettle();
    //assert
    expect(find.text("1234"), findsOneWidget);
  });

  testWidgets(
      'when enter valid pin 6 digits then dialog should be displayed with `Login success`',
      (WidgetTester tester) async {
    //arrange
    when(mockLoginService.authenticate("132495"))
        .thenAnswer((_) async => AuthorizationStatus.success);

    //Set screen size before run test
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

    //act
    await tester.tap(find.text("1"));
    await tester.tap(find.text("3"));
    await tester.tap(find.text("2"));
    await tester.tap(find.text("4"));
    await tester.tap(find.text("9"));
    await tester.tap(find.text("5"));
    await tester.pumpAndSettle();

    //assert
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Login success"), findsOneWidget);

    await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/call_api.png'));
  });

  testWidgets(
      'when enter valid pin 6 digits and received unauthorised response from server then dialog should be displayed with `Unauthorised`',
      (WidgetTester tester) async {
    //arrange
    when(mockLoginService.authenticate("132495"))
        .thenAnswer((_) async => AuthorizationStatus.unauthorised);

    //Set screen size before run test
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

    //act
    await tester.tap(find.text("1"));
    await tester.tap(find.text("3"));
    await tester.tap(find.text("2"));
    await tester.tap(find.text("4"));
    await tester.tap(find.text("9"));
    await tester.tap(find.text("5"));
    await tester.pumpAndSettle();

    //assert
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Unauthorised"), findsOneWidget);
  });

  testWidgets(
      'when enter valid pin 6 digits and received techinal error response from server then dialog should be displayed with `Facing technical difficulties`',
      (WidgetTester tester) async {
    //arrange
    when(mockLoginService.authenticate("132495"))
        .thenAnswer((_) async => AuthorizationStatus.technicalError);

    //Set screen size before run test
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

    //act
    await tester.tap(find.text("1"));
    await tester.tap(find.text("3"));
    await tester.tap(find.text("2"));
    await tester.tap(find.text("4"));
    await tester.tap(find.text("9"));
    await tester.tap(find.text("5"));
    await tester.pumpAndSettle();

    //assert
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Facing technical difficulties"), findsOneWidget);
  });

  testWidgets(
      'when enter invalid pin 6 digits then dialog should be displayed with `Pin format is invalid`',
      (WidgetTester tester) async {
    //arrange

    //Set screen size before run test
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

    //act
    await tester.tap(find.text("1"));
    await tester.tap(find.text("1"));
    await tester.tap(find.text("1"));
    await tester.tap(find.text("1"));
    await tester.tap(find.text("1"));
    await tester.tap(find.text("1"));
    await tester.pumpAndSettle();

    //assert
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Pin format is invalid"), findsOneWidget);
  });
}
