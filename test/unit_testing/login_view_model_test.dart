import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_view_model_test.mocks.dart';

@GenerateMocks([BuildContext, LoginService, PinRules])
void main() {
  group('LoginViewModel', () {
    late LoginViewModel loginViewModel;
    late MockLoginService mockLoginService;
    late MockPinRules mockPinRules;

    setUp(() {
      mockLoginService = MockLoginService();
      mockPinRules = MockPinRules();
      loginViewModel =
          LoginViewModel(mockLoginService, SortOrder.ascending, mockPinRules);
    });

    group('onDigitPressed', () {
      test(
          'given inputted pin is empty when digit is pressed then inputted pin should be added',
          () {
        // Arrange
        // Act
        loginViewModel.onDigitPressed(1, MockBuildContext());
        // Assert
        expect(loginViewModel.inputtedPin, '1');
      }, tags: 'unit');
      test(
          'given inputted pin is 5 digits when digit is pressed then inputted pin should be added',
          () {
        // Arrange
        when(mockPinRules.getErrorMessage(any)).thenReturn(null);
        final mockBuildContext = MockBuildContext();
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(2, mockBuildContext);
        loginViewModel.onDigitPressed(3, mockBuildContext);
        loginViewModel.onDigitPressed(4, mockBuildContext);
        loginViewModel.onDigitPressed(5, mockBuildContext);
        // Act
        loginViewModel.onDigitPressed(1, mockBuildContext);
        // Assert
        expect(loginViewModel.inputtedPin, '123451');
      }, tags: 'unit');

      test(
          'given inputted pin is 6 digits when digit is pressed then inputted pin should not be added',
          () {
        // Arrange
        when(mockPinRules.getErrorMessage(any)).thenReturn(null);
        final mockBuildContext = MockBuildContext();
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(2, mockBuildContext);
        loginViewModel.onDigitPressed(3, mockBuildContext);
        loginViewModel.onDigitPressed(4, mockBuildContext);
        loginViewModel.onDigitPressed(5, mockBuildContext);
        loginViewModel.onDigitPressed(6, mockBuildContext);
        // Act
        loginViewModel.onDigitPressed(1, mockBuildContext);
        // Assert
        expect(loginViewModel.inputtedPin, '123456');
        // Assert
      }, tags: 'unit');
      group('FE pin validation', () {});
      group('handle network call', () {});
    });
    group(
      'onDeleteButtonPressed',
      () {
        test(
            'given inputted pin is 1 digits when delete button is press then inputted should be empty',
            () {
          // Arrange
          final mockBuildContext = MockBuildContext();
          loginViewModel.onDigitPressed(1, mockBuildContext);
          // Act
          loginViewModel.onDeleteButtonPressed();
          // Assert
          expect(loginViewModel.inputtedPin, '');
        }, tags: 'unit');

        test(
            'given inputted pin is 6 digits when delete button is press then inputted should be removed 1 digit',
            () {
          when(mockPinRules.getErrorMessage(any)).thenReturn(null);
          // Arrange
          final mockBuildContext = MockBuildContext();
          loginViewModel.onDigitPressed(1, mockBuildContext);
          loginViewModel.onDigitPressed(1, mockBuildContext);
          loginViewModel.onDigitPressed(1, mockBuildContext);
          loginViewModel.onDigitPressed(1, mockBuildContext);
          loginViewModel.onDigitPressed(1, mockBuildContext);
          loginViewModel.onDigitPressed(1, mockBuildContext);
          // Act
          loginViewModel.onDeleteButtonPressed();
          // Assert
          expect(loginViewModel.inputtedPin, '11111');
        }, tags: 'unit');

        test(
            'given inputted pin is empty when delete button is press then nothing happened',
            () {
          // Arrange
          loginViewModel.onDeleteButtonPressed();
          // Assert
          expect(loginViewModel.inputtedPin, '');
        }, tags: 'unit');
      },
    );

    group('navigation', () {});
  });
}
