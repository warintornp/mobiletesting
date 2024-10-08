import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/pages/home_screen.dart';
import 'package:mobiletesting/pages/login_screen.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mobiletesting/pages/pin_grid_view.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'snapshot_test.mocks.dart';

@GenerateMocks([LoginViewModel])
@GenerateMocks([UserService])
void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  //ถามพี่แอนว่าทำไมมันไม่ผ่าน
  // testGoldens('Login sreen initial state with ascending pin order', (WidgetTester tester) async {
  //   final builder = DeviceBuilder()
  //     ..overrideDevicesForAllScenarios(devices: 
  //     [
  //       Device.iphone11,
  //       Device.tabletLandscape,
  //     ])
  //     ..addScenario(widget: MaterialApp(
  //         home: LoginScreen(),
  //     ));
  //   await tester.pumpDeviceBuilder(builder);
  //   await screenMatchesGolden(tester, 'login_screen');
  // });

  testGoldens('Dot initial state', (tester) async {
    final mockLoginWithPinViewModel = MockLoginViewModel();
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('');

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        const Device(name: 'Pixel3a 800 x 600', size: Size(800, 600)),
        Device.iphone11,
        Device.tabletPortrait,
      ])
      ..addScenario(widget: Dot(viewModel: mockLoginWithPinViewModel));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'dot_initial_state');
  });
  
  testGoldens('Dot state when input 1234', (tester) async {
    final mockLoginWithPinViewModel = MockLoginViewModel();
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('1234');

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        const Device(name: 'Pixel3a 800 x 600', size: Size(800, 600)),
        Device.tabletPortrait,
      ])
      ..addScenario(widget: Dot(viewModel: mockLoginWithPinViewModel));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'dot_state_when_input_1234');
  });

  testGoldens('Pin grid view ascending', (tester) async {
    await tester.pumpWidgetBuilder(
      PinGridView(
          sortOrder: SortOrder.ascending,
          deleteButtonOnPressed: () {},
          numberButtonOnPressed: (int number) {}
      )
      ,surfaceSize: Size(400, 900)
      ,textScaleSize: 1.0
    );
    await screenMatchesGolden(tester, 'pin_grid_view_ascending');
  });

  testGoldens('Pin grid view descending', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(
      PinGridView(
          sortOrder: SortOrder.descending,
          deleteButtonOnPressed: () {},
          numberButtonOnPressed: (int number) {}
      )
      ,surfaceSize: Size(400, 900)
      ,textScaleSize: 1.0
    );
    await screenMatchesGolden(tester, 'pin_grid_view_descending');
  });

  testGoldens('Home screen', (WidgetTester tester) async {
    final builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [
      Device.iphone11, 
      Device.tabletLandscape
    ])..addScenario(widget: 
        HomeScreen(
          userDetails: {'name': 'John Doe', 'email': 'john.doe@example.com'}
    ));
    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'home_screen');
  });

  testGoldens('Profile Widget', (WidgetTester tester) async {
    final mockUserDetails = {
      'name': 'John Doe',
      'email': 'john.doe@example.com'
    };
    final builder = GoldenBuilder.column()
      ..addScenario('user_profile_widget',
          UserProfileWidget(userDetails: mockUserDetails))
      ..addTextScaleScenario(
          'Large font size', UserProfileWidget(userDetails: mockUserDetails),
          textScaleFactor: 2.0)
      ..addTextScaleScenario(
          'Largest font size', UserProfileWidget(userDetails: mockUserDetails),
          textScaleFactor: 5.0);

    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'user_profile_widget');
  });

  testGoldens('Profile Widget with long text', (WidgetTester tester) async {
    final mockUserDetails = {
      'name': 'John Doe Re Me Fa Sol La Te Doeeeee',
      'email': 'john.doe@example.commmmmmmmmmmmmmmmmmmmmmm'
    };
    final builder = GoldenBuilder.column()
      ..addScenario('user_profile_widget',
          UserProfileWidget(userDetails: mockUserDetails))
      ..addTextScaleScenario(
          'Large font size', UserProfileWidget(userDetails: mockUserDetails),
          textScaleFactor: 2.0)
      ..addTextScaleScenario(
          'Largest font size', UserProfileWidget(userDetails: mockUserDetails),
          textScaleFactor: 5.0);

    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'user_profile_widget_long_text');
  });
}
