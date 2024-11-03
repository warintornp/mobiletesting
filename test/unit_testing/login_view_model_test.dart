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
        // Arrange/GIven
        // expect(loginViewModel.inputtedPin, '');

        // Act/When
        loginViewModel.onDigitPressed(1, MockBuildContext());

        // Assert/Then
        expect(loginViewModel.inputtedPin, '1');
      }, tags: 'unit');

      test(
          'given inputted pin is 5 digit when digit is pressed then inputted pin should be added',
          () async {
        // Arrange/Given
        when(mockPinRules.getErrorMessage("123456"))
            .thenReturn("Pin format is invalid");

        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());

        // Act/When
        await loginViewModel.onDigitPressed(6, MockBuildContext());

        // Assert/Then
        expect(loginViewModel.inputtedPin, '123456');
      }, tags: 'unit');

      test(
          'given inputted pin is 6 digits when digit is pressed then inputted pin should not be added',
          () async {
        // Arrange
        when(mockPinRules.getErrorMessage("123456"))
            .thenReturn("Pin format is invalid");
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());
        await loginViewModel.onDigitPressed(6, MockBuildContext());
        // Act
        loginViewModel.onDigitPressed(7, MockBuildContext());
        // Assert
        expect(loginViewModel.inputtedPin, '123456');
      }, tags: 'unit');

      test(
          'Given The customer is entering 6 digit a PIN when the PIN contains sequential digits then error message dialog displayed as “Pin format is invalid”',
          () async {
        // Arrange,
        when(mockPinRules.getErrorMessage("012345"))
            .thenReturn("Pin format is invalid");

        loginViewModel.onDigitPressed(0, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        // Act
        await loginViewModel.onDigitPressed(5, MockBuildContext());
        // Assert
        expect(loginViewModel.dialogMessage, "Pin format is invalid");
      });

      group('FE pin validation', () {});
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
      }, tags: 'unit');
      test(
          'given inputted pin is 6 digits when delete button is press then inputtedPin should be 5 digits',
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
        expect(loginViewModel.inputtedPin, '12345');
      }, tags: 'unit');
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

    group('onDialogClose', () {
      test(
          'given dialogMessage is not empty when onDialogClose is called then dialogMessage should be set to empty string',
          () async {
        // Arrange
        when(mockPinRules.getErrorMessage("111111"))
            .thenReturn("Pin format is invalid");
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(1, MockBuildContext());
        await loginViewModel.onDigitPressed(1, MockBuildContext());
        // Act
        loginViewModel.onDialogClose();
        // Assert
        expect(loginViewModel.dialogMessage, "");
      });
    });

    group(
        'handle network call after 6 digits pin has no error message from getErrorMessage',
        () {
      test(
          'when retrieve authorise success then set dialogMessage as ‘Login success’ ',
          () async {
        // Arrange
        when(mockPinRules.getErrorMessage("123456")).thenReturn(null);
        when(mockLoginService.authenticate("123456"))
            .thenAnswer((_) async => true);

        loginViewModel.onDigitPressed(1, MockBuildContext());
        loginViewModel.onDigitPressed(2, MockBuildContext());
        loginViewModel.onDigitPressed(3, MockBuildContext());
        loginViewModel.onDigitPressed(4, MockBuildContext());
        loginViewModel.onDigitPressed(5, MockBuildContext());

        // Act
        await loginViewModel.onDigitPressed(6, MockBuildContext());
        // Assert
        expect(loginViewModel.dialogMessage, "Login success");
      });
    });
  });
}
