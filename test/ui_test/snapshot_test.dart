import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/home_screen/home_screen.dart';
import 'package:mobiletesting/home_screen/home_view_model.dart';
import 'package:mobiletesting/login_screen/dot_view.dart';
import 'package:mobiletesting/login_screen/login_screen.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
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
  
  testGoldens('Dot widget - dot unfilled', (WidgetTester tester) async {
    //arrange
    when(mockLoginViewModel.inputtedPin).thenReturn("");

    //Create Dot widget
    await tester.pumpWidgetBuilder(Dot(viewModel: mockLoginViewModel),
        surfaceSize: Size(400, 800));

    //assert
    await screenMatchesGolden(tester, 'dot_unfilled');
  });

  testGoldens('Dot widget - dot filled', (WidgetTester tester) async {});

  testGoldens('PinGridView widget - num pad asceding order',
      (WidgetTester tester) async {});

  testGoldens('PinGridView widget - num pad desceding order',
      (WidgetTester tester) async {});

  testGoldens('Alert dialog', (WidgetTester tester) async {});

  testGoldens('login screen - No enter pin and numpad sord order ascending', (WidgetTester tester) async {
    when(mockLoginViewModel.dialogMessage).thenReturn("");
    when(mockLoginViewModel.inputtedPin).thenReturn("123456");
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginViewModel.isLoading).thenReturn(false);

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

  testGoldens('login screen - Has pin entered pin and numpad sord order ascending', (WidgetTester tester) async {
  });

  testGoldens('Login screen - multiple screen size',
      (WidgetTester tester) async {
    when(mockLoginViewModel.inputtedPin).thenReturn("");

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device(size: Size(400, 800), name: "custome_device"),
        Device.iphone11,
        Device.tabletPortrait
      ])
      ..addScenario(
          widget: MaterialApp(
        home: ChangeNotifierProvider<LoginViewModel>.value(
          value: mockLoginViewModel,
          child: LoginScreen(),
        ),
      ))
      ..addScenario(widget: Dot(viewModel: mockLoginViewModel));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'login_screen_multiple_sceen_size');
  });
}
