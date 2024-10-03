import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/pages/login_with_pin_screen_v2.dart';
import 'package:mobiletesting/pages/login_with_pin_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'snapshot_test.mocks.dart';

@GenerateMocks([LoginWithPinViewModel])
void main() {

  testGoldens('Login with Pin Screen Golden', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(LoginWithPinScreen());
    await multiScreenGolden(tester, 'login_sreen');
  });

  testGoldens('Dot Golden', (WidgetTester tester) async {
    final mockLoginWithPinViewModel = MockLoginWithPinViewModel();
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('1234');
    await tester.pumpWidgetBuilder(Dot(viewModel: mockLoginWithPinViewModel));
    await multiScreenGolden(tester, 'dot_when_input_1234');
  });

  testGoldens('Dot widget', (WidgetTester tester) async {
    final mockLoginWithPinViewModel = MockLoginWithPinViewModel();
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('');

    final builder = GoldenBuilder.column()
    ..addScenario('dot', Dot(viewModel: mockLoginWithPinViewModel))
    ..addTextScaleScenario('Large font size', Dot(viewModel: mockLoginWithPinViewModel), textScaleFactor: 2.0)
    ..addTextScaleScenario('Largest font size', Dot(viewModel: mockLoginWithPinViewModel), textScaleFactor: 3.0);

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'dot_default_state');
  });
}
