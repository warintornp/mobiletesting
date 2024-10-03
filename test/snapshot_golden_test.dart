import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/login_with_pin_screen_v2.dart';
import 'package:mobiletesting/pages/login_with_pin_view_model.dart';
import 'package:mobiletesting/pages/pin_grid_view.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'login_with_pin_view_model_test.mocks.dart';
import 'uitest/pin_entry_screen_test.mocks.dart';

@GenerateMocks([MockLoginWithPinViewModel])
void main() {

  testWidgets('Login with pin screen',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(home: LoginWithPinScreen()),
    );

    // Take a screenshot and compare it with a golden file
    await expectLater(
      find.byType(LoginWithPinScreen),
      matchesGoldenFile('goldens/ref/login-with-pin-screen.png'),
    );
  });

testWidgets('pin dot default state',
      (WidgetTester tester) async {

    final mockViewModel = MockLoginWithPinViewModel();
    when(mockViewModel.inputtedPin).thenReturn(''); 

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(
        body: Dot(viewModel: mockViewModel)
      )),
    );

    await tester.pumpAndSettle();

    // Take a screenshot and compare it with a golden file
    await expectLater(
      find.byType(Dot),
      matchesGoldenFile('goldens/ref/pin_key_default.png'),
    );
  });

  testWidgets('pin dot when enter`1234`',
      (WidgetTester tester) async {

    final mockViewModel = MockLoginWithPinViewModel();
    when(mockViewModel.inputtedPin).thenReturn('1234'); 

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(
        body: Dot(viewModel: mockViewModel)
      )),
    );

    await tester.pumpAndSettle();

    // Take a screenshot and compare it with a golden file
    await expectLater(
      find.byType(Dot),
      matchesGoldenFile('goldens/ref/pin_key.png'),
    );
  });

  
  testWidgets('Loading Indicator', (WidgetTester tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoadingIndicator()
        )
      )
    );

    await expectLater(
      find.byType(LoadingIndicator),
      matchesGoldenFile('goldens/ref/loading_indicator.png'),
    );
  });

  testWidgets('pin view',(WidgetTester tester) async {

    final mockViewModel = MockLoginWithPinViewModel();
    when(mockViewModel.keyPadsortOrder).thenReturn(SortOrder.descending);

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(
        body: PinGridWidget(viewModel: mockViewModel)
      )),
    );

    await tester.pumpAndSettle();

    // Take a screenshot and compare it with a golden file
    await expectLater(
      find.byType(PinGridWidget),
      matchesGoldenFile('goldens/ref/pin_grid_view_widget.png'),
    );
  });
}
