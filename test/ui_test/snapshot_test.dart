import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/pages/login_with_pin_screen_v2.dart';
import 'package:mobiletesting/pages/login_with_pin_view_model.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'snapshot_test.mocks.dart';

@GenerateMocks([LoginWithPinViewModel])
void main() {
  late MockLoginWithPinViewModel mockLoginWithPinViewModel;

  setUp(() {
    mockLoginWithPinViewModel = MockLoginWithPinViewModel();
  });

  testWidgets('Login with Pin Screen', (WidgetTester tester) async {
    // create login screen
    await tester.pumpWidget(const MaterialApp(
      home: LoginWithPinScreen(),
    ));

    await expectLater(find.byType(LoginWithPinScreen),
        matchesGoldenFile('ui_test/goldens/login_with_pin.png'));
  });

  testGoldens('Login with Pin Screen Golden', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(LoginWithPinScreen());
    await multiScreenGolden(tester, 'login_sreen');
  });

   testGoldens('Login with Pin Screen Golden', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Dot(viewModel: mockLoginWithPinViewModel),
      ),
    ));

    await expectLater(find.byType(Dot),
        matchesGoldenFile('ui_test/goldens/dotdotdot.png'));
  });

  // testGoldens('Dot widget', (WidgetTester tester) async {
  //   when(mockLoginWithPinViewModel.keyPadsortOrder).thenReturn(SortOrder.ascending);

  //   final widget = MaterialApp(
  //     home: Scaffold(
  //       body: Column(
  //         children: Dot(viewModel: mockLoginWithPinViewModel)),
  //       )
  //   );

  //   final builder = GoldenBuilder.column()
  //     ..addScenario('dot', widget);

  //   await tester.pumpWidgetBuilder(builder.build());
  //   await multiScreenGolden(tester, 'dot');
  // });
  // testGoldens('Login with Pin Screen Golden', (WidgetTester tester) async {
  //   final widget = MaterialApp(
  //     home: dot(),
  //   )
  //   final builder = DeviceBuilder()
  //     ..overrideDevicesForAllScenarios(devices: [Device.iphone11])
  //     ..addScenario(widget: ChangeNotifierProvider(create: create))

  //   await tester.pumpWidgetBuilder(ChangeNotifierProvider());
  //   await multiScreenGolden(tester, 'login_sreen');
  // });
}
