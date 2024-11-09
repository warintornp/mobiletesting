import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/login_screen.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([BuildContext, LoginViewModel])
void main() {
  late MockLoginViewModel mockLoginViewModel;
  setUp(() {
    mockLoginViewModel = MockLoginViewModel();
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

  testWidgets('when tap on delete button then onDeleteButtonPressed should get called ',
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

  testWidgets('when pin is valid and dialog message is not null then dialog displayed', (WidgetTester tester) async {
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

}
