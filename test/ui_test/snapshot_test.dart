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

  testGoldens('Login with Pin Screen Golden', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(LoginScreen());
    await multiScreenGolden(tester, 'login_sreen');
  });

  testGoldens('Dot Golden', (WidgetTester tester) async {
    final mockLoginWithPinViewModel = MockLoginViewModel();
    when(mockLoginWithPinViewModel.inputtedPin).thenReturn('1234');
    await tester.pumpWidgetBuilder(Dot(viewModel: mockLoginWithPinViewModel));
    await multiScreenGolden(tester, 'dot_when_input_1234');
  });

  testGoldens('Dot widget', (WidgetTester tester) async {
    final mockLoginViewModel = MockLoginViewModel();
    when(mockLoginViewModel.inputtedPin).thenReturn('');

    final builder = GoldenBuilder.column()
    ..addScenario('dot', Dot(viewModel: mockLoginViewModel))
    ..addTextScaleScenario('Large font size', Dot(viewModel: mockLoginViewModel), textScaleFactor: 2.0)
    ..addTextScaleScenario('Largest font size', Dot(viewModel: mockLoginViewModel), textScaleFactor: 3.0);

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'dot_default_state');
  });

  testGoldens('Pin Grid View', (WidgetTester tester) async {
    final mockLoginViewModel = MockLoginViewModel();
    when(mockLoginViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);
    when(mockLoginViewModel.inputtedPin).thenReturn('');

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

  testGoldens('Profile Widget', (WidgetTester tester) async {
    final mockUserDetails = {'name': 'John Doe', 'email': 'john.doe@example.com'};
    final builder = GoldenBuilder.column()
    ..addScenario('user_profile_widget', UserProfileWidget(userDetails: mockUserDetails))
    ..addTextScaleScenario('Large font size', UserProfileWidget(userDetails: mockUserDetails), textScaleFactor: 2.0)
    ..addTextScaleScenario('Largest font size', UserProfileWidget(userDetails: mockUserDetails), textScaleFactor: 5.0);

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'user_profile_widget');
  });

  testGoldens('Profile Widget - Logn user info', (WidgetTester tester) async {
    final mockUserDetails = {'name': 'John Doe Re Me Fa Sol La Te Doeeeee', 'email': 'john.doe@example.commmmmmmmmmmmmmmmmmmmmmm'};
    final builder = GoldenBuilder.column()
    ..addScenario('user_profile_widget', UserProfileWidget(userDetails: mockUserDetails))
    ..addTextScaleScenario('Large font size', UserProfileWidget(userDetails: mockUserDetails), textScaleFactor: 2.0)
    ..addTextScaleScenario('Largest font size', UserProfileWidget(userDetails: mockUserDetails), textScaleFactor: 5.0);

    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'user_profile_widget_long_text');
  });
}