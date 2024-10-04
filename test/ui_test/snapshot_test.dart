import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/pages/home_screen.dart';
import 'package:mobiletesting/pages/login_with_pin_screen_v2.dart';
import 'package:mobiletesting/pages/login_with_pin_view_model.dart';
import 'package:mobiletesting/pages/pin_grid_view.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'snapshot_test.mocks.dart';

@GenerateMocks([LoginWithPinViewModel])
@GenerateMocks([UserService])
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

  testGoldens('Pin Grid View', (WidgetTester tester) async {
    final mockLoginWithPinViewModel = MockLoginWithPinViewModel();
    when(mockLoginWithPinViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('');

    await tester.pumpWidgetBuilder(PinGridView(
      sortOrder: SortOrder.ascending, 
      deleteButtonOnPressed: () {}, 
      numberButtonOnPressed: (int number) {}));

    await multiScreenGolden(tester, 'pin_grid_view');
  });

  testGoldens('Home screen', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(HomeScreen(
      userDetails: {'name': 'John Doe', 'email': 'john.doe@example.com'}));
    await multiScreenGolden(tester, 'home_screen');
  });
}
