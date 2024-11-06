import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/login_screen.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginViewModel])
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

    // await expectLater(
    //     find.byType(MaterialApp), matchesGoldenFile('goldens/dialog-4.png'));
  }, tags: 'widget');

  testWidgets("Enter pin then onDigitPressed function get call", (WidgetTester tester) async {
    //Set screen size before run test
    final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));
    //
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    //Arrange
    when(mockLoginViewModel.inputtedPin).thenReturn("123");
    when(mockLoginViewModel.dialogMessage).thenReturn("");
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginViewModel.isLoading).thenReturn(false);

    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>(
              create: (_) => mockLoginViewModel, child: LoginScreen())),
    );
    //Act
    await tester.tap(find.text("1"));
    await tester.pumpAndSettle();
    
    //Assert
    verify(mockLoginViewModel.onDigitPressed(1, any)).called(1);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Delete pin then onDigitPressed function get call", (WidgetTester tester) async {
    //Set screen size before run test
    final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));
    //useful if widget rander diff on each platform
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    //Arrange
    when(mockLoginViewModel.inputtedPin).thenReturn("123");
    when(mockLoginViewModel.dialogMessage).thenReturn("");
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginViewModel.isLoading).thenReturn(false);

    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>(
              create: (_) => mockLoginViewModel, child: LoginScreen())),
    );
    //Act
    await tester.tap(find.byKey(Key("deleteButton")));
    await tester.pumpAndSettle();
    
    //Assert
    verify(mockLoginViewModel.onDeleteButtonPressed()).called(1);
    await expectLater(
        find.byType(MaterialApp), matchesGoldenFile('goldens/dialog-3.png'));
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Dialog displayed when receive success message", (WidgetTester tester) async {
    //Set screen size before run test
    final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //Arrange
    when(mockLoginViewModel.inputtedPin).thenReturn("12345");
    when(mockLoginViewModel.dialogMessage).thenReturn("Login Success");
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginViewModel.isLoading).thenReturn(false);

    await tester.pumpWidget(
      MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>(
              create: (_) => mockLoginViewModel, child: LoginScreen())),
    );

    //Act
    await tester.tap(find.text("5"));
    await tester.pumpAndSettle();
    
    //Assert
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Login Success"), findsOneWidget);
  });

}
