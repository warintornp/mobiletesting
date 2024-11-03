import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mockito/annotations.dart';

import 'login_view_model_test.mocks.dart';

@GenerateMocks([BuildContext, LoginService])
void main() {
  group('LoginViewModel', () {
    late LoginViewModel loginViewModel;
    late MockLoginService mockLoginService;

    setUp(() {
      mockLoginService = MockLoginService();
      loginViewModel = LoginViewModel(mockLoginService, SortOrder.ascending);
    });

    group('onDigitPressed', () {
      test(
          'given inputted pin is empty when digit is pressed then inputted pin should be added',
          () {
        // Arrange/GIven
        // expect(loginViewModel.inputtedPin, '');

        // Act/When
        loginViewModel.onDigitPressed(1, MockBuildContext());

        // Assert/Then
        expect(loginViewModel.inputtedPin, '1');
      }, tags: 'unit');

      test(
          'given inputted pin is 5 digit when digit is pressed then inputted pin should be added',
          () {
        // Arrange/Given
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());

        // Act/When
        loginViewModel.onDigitPressed(6, MockBuildContext());

        // Assert/Then
        expect(loginViewModel.inputtedPin, '123456');
      }, tags: 'unit');

      test(
          'given inputted pin is 6 digits when digit is pressed then inputted pin should not be added',
          () {
        // Arrange
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());
        loginViewModel.onDigitPressed(6, MockBuildContext());
        // Act
        loginViewModel.onDigitPressed(7, MockBuildContext());
        // Assert
        expect(loginViewModel.inputtedPin, '123456');
      }, tags: 'unit');
      group('FE pin validation', () {});
      group('handle network call', () {});
    });
    group('onDeleteButtonPressed', () {
      test(
          'given inputted pin is 1 digits when delete button is press then inputtedPin should be empty',
          () {
        // Arrange
        loginViewModel.onDigitPressed(1, MockBuildContext());
        // Act
        loginViewModel.onDeleteButtonPressed();
        // Assert
        expect(loginViewModel.inputtedPin, '');
      });
      test(
          'given inputted pin is 6 digits when delete button is press then inputtedPin should be 5 digits',
          () {
        // Arrange
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());
        loginViewModel.onDigitPressed(6, MockBuildContext());
        // Act
        loginViewModel.onDeleteButtonPressed();
        // Assert
        expect(loginViewModel.inputtedPin, '12345');
      });
      test(
          'given inputted pin is empty when delete button is click then _inputtedPin still empty',
          () {
        // Arrange

        // Act
        loginViewModel.onDeleteButtonPressed();
        // Assert
        expect(loginViewModel.inputtedPin, '');
      }, tags: 'unit');
    });

    group('navigation', () {});
  });
}
