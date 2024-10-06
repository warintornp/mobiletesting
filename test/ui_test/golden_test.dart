import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/pages/login_screen.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'snapshot_test.mocks.dart';

@GenerateMocks([LoginViewModel])
void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  testGoldens('Dot with no input', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1.0;

    final mockLoginWithPinViewModel = MockLoginViewModel();
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('');

    final builder = DeviceBuilder()
      // ..overrideDevicesForAllScenarios(devices: [
      //   Device.iphone11,
      //   const Device(name: 'Pixel3a 1080 x 2220', size: Size(1080, 2220)),
      //   Device.phone,
      //   Device.tabletPortrait,
      // ])
      ..addScenario(
          widget: Dot(viewModel: mockLoginWithPinViewModel),
          name: 'Dot Default',
          onCreate: (scenarioWidgetKey) async {
            final dot = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(Key('dot_default')),
            );
            expect(dot, findsNothing);
          }
        );
    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'dot_default_default_pixel_physical');

  });

}
