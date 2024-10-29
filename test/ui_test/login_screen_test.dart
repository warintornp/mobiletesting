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

  testWidgets('display dialog', (WidgetTester tester) async {
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
    await tester.tap(find.text("1"));
    await tester.tap(find.text("3"));
    await tester.tap(find.text("2"));
    await tester.tap(find.text("4"));
    await tester.tap(find.text("5"));
    await tester.tap(find.text("7"));
    await tester.pumpAndSettle();
    //Assert
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
