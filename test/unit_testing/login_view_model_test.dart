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
        // Arrange/GIVEN

        // Act/WHEN
        loginViewModel.onDigitPressed(5, MockBuildContext());

        // Assert/THEN
        expect(loginViewModel.inputtedPin, "5");
      }, tags: 'unit');

      test(
          'given inputted pin is 5 digits when digit is pressed then inputted pin should be added',
          () {
        // Arrange
        when(mockPinRules.getErrorMessage("123456"))
            .thenReturn("Pin format is invalid");

        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());

        // Act
        loginViewModel.onDigitPressed(6, MockBuildContext());

        // Assert
        expect(loginViewModel.inputtedPin, "123456");
      }, tags: 'unit');

      test(
          'given inputted pin is 6 digits when digit is pressed then inputted pin should not be added',
          () {
        // Arrange
        when(mockPinRules.getErrorMessage("123456"))
            .thenReturn("Pin format is invalid");
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());
        loginViewModel.onDigitPressed(6, MockBuildContext());

        // Act
        loginViewModel.onDigitPressed(7, MockBuildContext());
        // Assert
        expect(loginViewModel.inputtedPin, "123456");
      }, tags: 'unit');

      group('pinValidation', () {
        test(
            'Given The customer is entering 6 digit a PIN when the PIN contains sequential digits then dialogMessage displayed as “Pin format is invalid”',
            () {
          // Arrange
          when(mockPinRules.getErrorMessage("123456"))
              .thenReturn("Pin format is invalid");

          loginViewModel.onDigitPressed(1, MockBuildContext());
          loginViewModel.onDigitPressed(2, MockBuildContext());
          loginViewModel.onDigitPressed(3, MockBuildContext());
          loginViewModel.onDigitPressed(4, MockBuildContext());
          loginViewModel.onDigitPressed(5, MockBuildContext());

          // Act
          loginViewModel.onDigitPressed(6, MockBuildContext());
          // Assert
          expect(loginViewModel.dialogMessage, "Pin format is invalid");
        });

        test(
            'Given The customer is entering 6 digit a PIN when the PIN contains no sequential digits then dialogMessage displayed as "Ready to submit pin."',
            () {
          // Arrange
          when(mockPinRules.getErrorMessage("123465")).thenReturn(null);

          loginViewModel.onDigitPressed(1, MockBuildContext());
          loginViewModel.onDigitPressed(2, MockBuildContext());
          loginViewModel.onDigitPressed(3, MockBuildContext());
          loginViewModel.onDigitPressed(4, MockBuildContext());
          loginViewModel.onDigitPressed(6, MockBuildContext());

          // Act
          loginViewModel.onDigitPressed(5, MockBuildContext());
          // Assert
          expect(loginViewModel.dialogMessage, "Ready to submit pin.");
        });
      });

      // test(
      //     'Given The customer is entering 6 digit a PIN when the PIN not contains sequential digits then dialogMessage displayed as null',
      //     () {});

      group('FE pin validation', () {});
      group('handle network call', () {});
    });
    group('onDeleteButtonPressed', () {
      test(
          'given inputted pin is 1 digit when delete button is click then last digit from inputtedPin will be "" ',
          () {
        // Arrange
        loginViewModel.onDigitPressed(7, MockBuildContext());

        // Act
        loginViewModel.onDeleteButtonPressed();
        // Assert
        expect(loginViewModel.inputtedPin, "");
      }, tags: 'unit');
      test(
          'given inputted pin is 6 digit when delete button is click then last digit from inputtedPin will be removed ',
          () {
        // Arrange
        when(mockPinRules.getErrorMessage("123456"))
            .thenReturn("Pin format is invalid");

        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());
        loginViewModel.onDigitPressed(6, MockBuildContext());

        // Act
        loginViewModel.onDeleteButtonPressed();
        // Assert
        expect(loginViewModel.inputtedPin, "12345");
      }, tags: 'unit');

      test(
          'given inputted pin is 0 digit when delete button is click then remove no digit from inputtedPin',
          () {
        // Arrange

        // Act
        loginViewModel.onDeleteButtonPressed();
        // Assert
        expect(loginViewModel.inputtedPin, "");
      }, tags: 'unit');
    });

    group('onDialogClose', () {
      test(
          'given dialogMessage is not empty when onDialogClose is called then dialogMessage should be set to empty string',
          () {
        // Arrange
        when(mockPinRules.getErrorMessage("111111"))
            .thenReturn("Pin format is invalid");
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        // Act
        loginViewModel.onDialogClose();
        // Assert
        expect(loginViewModel.dialogMessage, "");
      });
    });
  });
}
