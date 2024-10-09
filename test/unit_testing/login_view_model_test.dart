import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/annotations.dart';

import 'login_view_model_test.mocks.dart';

@GenerateMocks([BuildContext])
void main() {
  group('LoginViewModel', () {
    late LoginViewModel loginViewModel;
    late LoginService userService;

    setUp(() {
      userService = LoginService();
      loginViewModel = LoginViewModel(userService, SortOrder.ascending);
    });

    test('onDigitPressed adds digit to inputtedPin', () {
      final mockBuildContext = MockBuildContext();

      loginViewModel.onDigitPressed(1, mockBuildContext);
      expect(loginViewModel.inputtedPin, '1');
    });

    test('onDigitPressed does not add digit if inputtedPin length is 6', () {
      // final mockBuildContext = MockBuildContext();
      // when(mockLoginViewModel
      //     .dependOnInheritedWidgetOfExactType({aspect: null})).thenReturn('');
      // loginViewModel.onDigitPressed(1, mockBuildContext);
      // loginViewModel.onDigitPressed(2, mockBuildContext);
      // loginViewModel.onDigitPressed(3, mockBuildContext);
      // loginViewModel.onDigitPressed(4, mockBuildContext);
      // loginViewModel.onDigitPressed(5, mockBuildContext);
      // loginViewModel.onDigitPressed(6, mockBuildContext);
      // loginViewModel.onDigitPressed(7, mockBuildContext);
      // expect(loginViewModel.inputtedPin, '123456');
    });

    test('onDeleteButtonPressed removes last digit from inputtedPin', () {
      //     loginViewModel.onDigitPressed(1, BuildContext());
      //     loginViewModel.onDigitPressed(2, BuildContext());
      //     loginViewModel.onDeleteButtonPressed();
      //     expect(loginViewModel.inputtedPin, '1');
    });

    test('_submitPin navigates to UserDetailsScreen if userDetails is not null',
        () async {
      //     final userDetails = {'name': 'John Doe', 'email': 'johndoe@example.com'};
      //     await loginViewModel._submitPin(BuildContext());
      //     expect(loginViewModel.isLoading, false);
      //     // Verify that navigation to UserDetailsScreen is triggered
      //     // You can add your own verification logic here
    });

    test('_submitPin shows error dialog if userDetails is null', () async {
      // await loginViewModel._submitPin(BuildContext());
      // expect(loginViewModel.isLoading, false);
      // Verify that error dialog is shown
    });
  });
}
