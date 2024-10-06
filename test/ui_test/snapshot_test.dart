import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/pages/home_screen.dart';
import 'package:mobiletesting/pages/login_screen.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mobiletesting/pages/login_with_pin_view_model.dart';
import 'package:mobiletesting/pages/pin_grid_view.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'snapshot_test.mocks.dart';

@GenerateMocks([LoginViewModel])
@GenerateMocks([UserService])
void main() {
   setUpAll(() async {
    await loadAppFonts();
  });

  // testGoldens('Login sreen initial state', (WidgetTester tester) async {
  //   await tester.pumpWidgetBuilder(
  //     MaterialApp(
  //       home: ChangeNotifierProvider(
  //         create: (_) => LoginWithPinViewModel(UserService(), SortOrder.ascending),
  //         child: LoginScreen(),
  //       )
  //     )
  //   );
  //   await multiScreenGolden(
  //     tester, 
  //     'login_sreen_initial_state', 
  //     devices: [
  //       Device.iphone11,
  //       const Device(name: 'Pixel3a 800 x 600', size: Size(1080, 2220)),
  //       Device.phone,
  //       Device.tabletPortrait
  //     ]);
  //   // await expectLater(find.byType(LoginScreen), matchesGoldenFile('login_screen_initial'));
  // });

  testGoldens('Login sreen initial state - pin ascending', (WidgetTester tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          const Device(name: 'Pixel3a 800 x 600', size: Size(800, 600)),
          Device.tabletPortrait,])
      ..addScenario(
          widget: Dot(viewModel: LoginViewModel(UserService(), SortOrder.ascending)));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'Login_screen_initial_state_ascending');
  });

  testGoldens('Login sreen initial state - pin descending', (WidgetTester tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.iphone11,
          const Device(name: 'Pixel3a 800 x 600', size: Size(800, 600)),
          Device.phone,
          Device.tabletPortrait,])
      ..addScenario(
          widget: Dot(viewModel: LoginViewModel(UserService(), SortOrder.descending)));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'Login_screen_initial_state_descending');
  });

  testGoldens('Dot initial state', (WidgetTester tester) async {
    final mockLoginWithPinViewModel = MockLoginViewModel();
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('');

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        const Device(name: 'Pixel3a 800 x 600', size: Size(800, 600)),
        Device.tabletPortrait,
      ])
      ..addScenario(
          widget: Dot(viewModel: mockLoginWithPinViewModel));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'dot__initial_state');
  });

  testGoldens('Dot state when input 1234', (WidgetTester tester) async {
    final mockLoginWithPinViewModel = MockLoginViewModel();
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('1234');

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        const Device(name: 'Pixel3a 800 x 600', size: Size(800, 600)),
        Device.tabletPortrait,
      ])
      ..addScenario(
          widget: Dot(viewModel: mockLoginWithPinViewModel));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'dot_state_when_input_1234');
  });

  testGoldens('Dot state when input 1234567', (WidgetTester tester) async {
    final mockLoginWithPinViewModel = MockLoginViewModel();
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('1234567');

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        const Device(name: 'Pixel3a 800 x 600', size: Size(800, 600)),
        Device.tabletPortrait,
      ])
      ..addScenario(
          widget: Dot(viewModel: mockLoginWithPinViewModel));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'dot_state_when_input_1234567');
  });

  // testGoldens('Pin grid accessibility', (WidgetTester tester) async {
  //   // final widget = PinGridView(
  //   //   sortOrder: SortOrder.ascending, 
  //   //   deleteButtonOnPressed: () {}, 
  //   //   numberButtonOnPressed: (int number) {});
    
  //   final builder = GoldenBuilder.column()
  //   ..addScenario('pin_grid_accessibility', PinGridView(
  //     sortOrder: SortOrder.ascending, 
  //     deleteButtonOnPressed: () {}, 
  //     numberButtonOnPressed: (int number) {}));
  //   // ..addTextScaleScenario('Large font size', widget, textScaleFactor: 2.0)
  //   // ..addTextScaleScenario('Largest font size', widget, textScaleFactor: 5.0);

  //   await tester.pumpWidgetBuilder(builder.build());
  //   await screenMatchesGolden(tester, 'pin_grid_accessibility');
  // });

  testGoldens('Pin Grid View', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(PinGridView(
      sortOrder: SortOrder.ascending, 
      deleteButtonOnPressed: () {}, 
      numberButtonOnPressed: (int number) {}));

    await screenMatchesGolden(tester, 'pin_grid_view');
  });

  testGoldens('Home screen', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(HomeScreen(
      userDetails: {'name': 'John Doe', 'email': 'john.doe@example.com'}));
    await screenMatchesGolden(tester, 'home_screen');
  });

  testGoldens('Profile Widget', (WidgetTester tester) async {
    final mockUserDetails = {'name': 'John Doe', 'email': 'john.doe@example.com'};
    final builder = GoldenBuilder.column()
    ..addScenario('user_profile_widget', UserProfileWidget(userDetails: mockUserDetails))
    ..addTextScaleScenario('Large font size', UserProfileWidget(userDetails: mockUserDetails), textScaleFactor: 2.0)
    ..addTextScaleScenario('Largest font size', UserProfileWidget(userDetails: mockUserDetails), textScaleFactor: 5.0);

    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'user_profile_widget');
  });

  testGoldens('Profile Widget with long text', (WidgetTester tester) async {
    final mockUserDetails = {'name': 'John Doe Re Me Fa Sol La Te Doeeeee', 'email': 'john.doe@example.commmmmmmmmmmmmmmmmmmmmmm'};
    final builder = GoldenBuilder.column()
    ..addScenario('user_profile_widget', UserProfileWidget(userDetails: mockUserDetails))
    ..addTextScaleScenario('Large font size', UserProfileWidget(userDetails: mockUserDetails), textScaleFactor: 2.0)
    ..addTextScaleScenario('Largest font size', UserProfileWidget(userDetails: mockUserDetails), textScaleFactor: 5.0);

    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'user_profile_widget_long_text');
  });
}
