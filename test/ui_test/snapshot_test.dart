import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
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

@GenerateMocks([LoginViewModel])
void main() {
  late MockLoginViewModel mockLoginViewModel;
  setUpAll(() async {
    mockLoginViewModel = MockLoginViewModel();
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

  testGoldens('Login screen - dot unfilled', (WidgetTester tester) async {
    when(mockLoginViewModel.inputtedPin).thenReturn("");
    await tester.pumpWidgetBuilder(
        Dot(viewModel: mockLoginViewModel),
        surfaceSize: Size(400, 800));
    await screenMatchesGolden(tester, 'dot_unfilled');
  });

  testGoldens('Login screen - dot filled', (WidgetTester tester) async {
    when(mockLoginViewModel.inputtedPin).thenReturn("1234");
    await tester.pumpWidgetBuilder(
        Dot(viewModel: mockLoginViewModel),
        surfaceSize: Size(400, 800));
    await screenMatchesGolden(tester, 'dot_input_1234');
  });

  testGoldens('Login screen - num pad asceding order', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(
        PinGridView(
            sortOrder: SortOrder.ascending,
            deleteButtonOnPressed: () {},
            numberButtonOnPressed: (int num) {}),
        surfaceSize: Size(400, 800));
    await screenMatchesGolden(tester, 'numpad_asc');
  });

  testGoldens('Login screen - num pad desceding order', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(
        PinGridView(
            sortOrder: SortOrder.descending,
            deleteButtonOnPressed: () {},
            numberButtonOnPressed: (int num) {}),
        surfaceSize: Size(400, 800));
    await screenMatchesGolden(tester, 'numpad_desc');
  });
}
