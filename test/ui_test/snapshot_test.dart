import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/home_screen/home_screen.dart';
import 'package:mobiletesting/home_screen/home_view_model.dart';
import 'package:mobiletesting/login_screen/dot_view.dart';
import 'package:mobiletesting/login_screen/login_screen.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mobiletesting/login_screen/pin_grid_view.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'snapshot_test.mocks.dart';

@GenerateMocks([LoginViewModel, HomeViewModel])
void main() {
  late MockLoginViewModel mockLoginViewModel;
  late MockHomeViewModel mockHomeViewModel;

  setUpAll(() async {
    mockLoginViewModel = MockLoginViewModel();
    mockHomeViewModel = MockHomeViewModel();
    //Load app font
    await loadAppFonts();
  });

  testGoldens('example of snapshot testing', (tester) async {
    // // Arrange
    // final mockViewModelA = MockViewModelA();
    // when(mockViewModelA.functionB).thenReturn('');

    // final builder = DeviceBuilder()
    //   ..overrideDevicesForAllScenarios(devices: [
    //     const Device(name: 'Pixel3a 800 x 600', size: Size(800, 600)),
    //     Device.iphone11,
    //     Device.tabletPortrait,
    //   ])
    //   ..addScenario(widget: Text(''));

    // // Act
    // await tester.pumpDeviceBuilder(builder);
    // // Assert
    // await screenMatchesGolden(tester, 'expected_golden_image');
  });

  testGoldens('example of snapshot testing1', (tester) async {
    // // Arrange, Act
    // await tester.pumpWidgetBuilder(Text(''),
    //     surfaceSize: Size(400, 900), textScaleSize: 1.0);
    // // Assert
    // await screenMatchesGolden(tester, 'pin_grid_view_ascending');
  });

  testGoldens('Login screen - dot unfilled - multiple screen size',
      (WidgetTester tester) async {
    when(mockLoginViewModel.inputtedPin).thenReturn("");
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device(size: Size(400, 800), name: "custome_device"),
        Device.iphone11,
        Device.tabletPortrait
      ])
      ..addScenario(widget: Dot(viewModel: mockLoginViewModel));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'dot_unfilled_multiple_sceen_size');
  });

  testGoldens('Login screen - dot unfilled', (WidgetTester tester) async {
    when(mockLoginViewModel.inputtedPin).thenReturn("");

    await tester.pumpWidgetBuilder(Dot(viewModel: mockLoginViewModel),
        surfaceSize: Size(400, 800));
    await screenMatchesGolden(tester, 'dot_unfilled');
  });

  testGoldens('Login screen - dot filled', (WidgetTester tester) async {
    when(mockLoginViewModel.inputtedPin).thenReturn("1234");
    await tester.pumpWidgetBuilder(Dot(viewModel: mockLoginViewModel),
        surfaceSize: Size(400, 800));
    await screenMatchesGolden(tester, 'dot_input_1234');
  });

  testGoldens('Login screen - num pad asceding order',
      (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(
        PinGridView(
            sortOrder: SortOrder.ascending,
            deleteButtonOnPressed: () {},
            numberButtonOnPressed: (int num) {}),
        surfaceSize: Size(400, 800),
        textScaleSize: 3);
    await screenMatchesGolden(tester, 'numpad_asc');
  });

  testGoldens('Login screen - num pad desceding order',
      (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(
        PinGridView(
            sortOrder: SortOrder.descending,
            deleteButtonOnPressed: () {},
            numberButtonOnPressed: (int num) {}),
        surfaceSize: Size(400, 800));
    await screenMatchesGolden(tester, 'numpad_desc');
  });

  testGoldens('dialog', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(Center(
        child: AlertDialog(
      title: Text("Error"),
      content: Text("Test test"),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('OK'),
        ),
      ],
    )));
    await screenMatchesGolden(tester, 'dialog');
  });

  testGoldens('login screen - Default state', (WidgetTester tester) async {
    when(mockLoginViewModel.dialogMessage).thenReturn("");
    when(mockLoginViewModel.inputtedPin).thenReturn("123456");
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginViewModel.isLoading).thenReturn(false);
    when(mockLoginViewModel.shouldNavigateToHome).thenReturn(false);

    await tester.pumpWidgetBuilder(
        MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>.value(
            value: mockLoginViewModel,
            child: LoginScreen(),
          ),
        ),
        surfaceSize: Size(400, 800),
        textScaleSize: 4);
    await screenMatchesGolden(tester, 'login_screen');
  });

  testGoldens('Home screen - Default state', (WidgetTester tester) async {
    //Arrange
    when(mockHomeViewModel.userDetails)
        .thenReturn({'name': 'John Doe', 'email': 'john.doe@example.com'});

    await tester.pumpWidgetBuilder(
      ChangeNotifierProvider<HomeViewModel>(
        create: (_) => mockHomeViewModel,
        child: HomeScreen(),
      ),
      surfaceSize: Size(400, 800)
    );
    //Act
    await tester.pumpAndSettle();
    //Assert
    await screenMatchesGolden(tester, 'home_screen');
  });
}
