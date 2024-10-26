import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/authorization_status.dart';
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
        when(mockLoginService.authenticate(any))
            .thenAnswer((_) async => AuthorizationStatus.success);

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
          () async {
        // Arrange
        when(mockPinRules.getErrorMessage(any)).thenReturn(null);
        when(mockLoginService.authenticate(any))
            .thenAnswer((_) async => AuthorizationStatus.success);

        final mockBuildContext = MockBuildContext();
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(2, mockBuildContext);
        loginViewModel.onDigitPressed(3, mockBuildContext);
        loginViewModel.onDigitPressed(4, mockBuildContext);
        loginViewModel.onDigitPressed(5, mockBuildContext);
        await loginViewModel.onDigitPressed(6, mockBuildContext);
        // Act
        await loginViewModel.onDigitPressed(1, mockBuildContext);
        // Assert
        expect(loginViewModel.inputtedPin, '123456');
        // Assert
      }, tags: 'unit');
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
            () async {
          when(mockPinRules.getErrorMessage(any)).thenReturn(null);
          when(mockLoginService.authenticate(any))
              .thenAnswer((_) async => AuthorizationStatus.success);
          // Arrange
          final mockBuildContext = MockBuildContext();
          loginViewModel.onDigitPressed(1, mockBuildContext);
          loginViewModel.onDigitPressed(1, mockBuildContext);
          loginViewModel.onDigitPressed(1, mockBuildContext);
          loginViewModel.onDigitPressed(1, mockBuildContext);
          loginViewModel.onDigitPressed(1, mockBuildContext);
          await loginViewModel.onDigitPressed(1, mockBuildContext);
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

    group('dialog diaplay', () {
      // test(
      //     'given inputted pin is 6 digits when getErrorMessage is null then publish dialogMessage as "success: Ready to submit pin"',
      //     () {
      //   when(mockPinRules.getErrorMessage(any)).thenReturn(null);
      //   // Arrange
      //   final mockBuildContext = MockBuildContext();
      //   loginViewModel.onDigitPressed(1, mockBuildContext);
      //   loginViewModel.onDigitPressed(1, mockBuildContext);
      //   loginViewModel.onDigitPressed(1, mockBuildContext);
      //   loginViewModel.onDigitPressed(1, mockBuildContext);
      //   loginViewModel.onDigitPressed(1, mockBuildContext);
      //   loginViewModel.onDigitPressed(1, mockBuildContext);
      //   // Act
      //   loginViewModel.onDeleteButtonPressed();
      //   // Assert
      //   expect(loginViewModel.dialogMessage, "success: Ready to submit pin");
      //   // verify(loginViewModel.notifyListeners()).called(2);
      // }, tags: 'unit');

      test(
          'given inputted pin is 6 digits when getErrorMessage is not null then publish dialogMessage as "Pin format is invalid"',
          () async {
        when(mockPinRules.getErrorMessage(any))
            .thenReturn("Pin format is invalid");
        // Arrange
        final mockBuildContext = MockBuildContext();
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(1, mockBuildContext);
        await loginViewModel.onDigitPressed(1, mockBuildContext);
        // Act
        loginViewModel.onDeleteButtonPressed();
        // Assert
        expect(loginViewModel.dialogMessage, "Pin format is invalid");
        // verify(loginViewModel.notifyListeners()).called(2);
      }, tags: 'unit');
    });

    group('onDialogClose', () {
      test(
          'given dialogMessage is not empty when dialog is closed then dialogMessage should be empty',
          () async {
        // Arrange
        when(mockPinRules.getErrorMessage(any)).thenReturn(null);
        when(mockLoginService.authenticate(any))
            .thenAnswer((_) async => AuthorizationStatus.unauthorised);
        final mockBuildContext = MockBuildContext();
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(1, mockBuildContext);
        await loginViewModel.onDigitPressed(1, mockBuildContext);

        // Act
        loginViewModel.onDialogClose();
        // Assert
        expect(loginViewModel.dialogMessage, "");
      }, tags: 'unit');
    });

    group(
        'API handling after 6 digits PIN passed validation, PIN authentication',
        () {
      test(
          'Given user input 6 digits is passed PIN validation, when retrieve success API authentication, then display dialog "Login success"',
          () async {
        // Arrange
        when(mockPinRules.getErrorMessage(any)).thenReturn(null);
        when(mockLoginService.authenticate(any))
            .thenAnswer((_) async => AuthorizationStatus.success);
        final mockBuildContext = MockBuildContext();
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(2, mockBuildContext);
        loginViewModel.onDigitPressed(3, mockBuildContext);
        loginViewModel.onDigitPressed(4, mockBuildContext);
        loginViewModel.onDigitPressed(5, mockBuildContext);

        // Act
        await loginViewModel.onDigitPressed(1, mockBuildContext);
        // Assert
        expect(loginViewModel.dialogMessage, 'Login success');
      }, tags: 'unit');
      test(
          'Given user input 6 digits is passed PIN validation, when call API and got "Unauthorised" error, then display dialog "Unauthorised"',
          () async {
        // Arrange
        when(mockPinRules.getErrorMessage(any)).thenReturn(null);
        when(mockLoginService.authenticate(any))
            .thenAnswer((_) async => AuthorizationStatus.unauthorised);
        final mockBuildContext = MockBuildContext();
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(2, mockBuildContext);
        loginViewModel.onDigitPressed(3, mockBuildContext);
        loginViewModel.onDigitPressed(4, mockBuildContext);
        loginViewModel.onDigitPressed(5, mockBuildContext);

        // Act
        await loginViewModel.onDigitPressed(1, mockBuildContext);
        // Assert
        expect(loginViewModel.dialogMessage, 'Unauthorised');
      }, tags: 'unit');
      test(
          'Given user input 6 digits is passed PIN validation, when call API and got "technical" error, then display dialog "Facing technical difficulties"',
          () async {
        // Arrange
        when(mockPinRules.getErrorMessage(any)).thenReturn(null);
        when(mockLoginService.authenticate(any))
            .thenAnswer((_) async => AuthorizationStatus.technicalError);
        final mockBuildContext = MockBuildContext();
        loginViewModel.onDigitPressed(1, mockBuildContext);
        loginViewModel.onDigitPressed(2, mockBuildContext);
        loginViewModel.onDigitPressed(3, mockBuildContext);
        loginViewModel.onDigitPressed(4, mockBuildContext);
        loginViewModel.onDigitPressed(5, mockBuildContext);

        // Act
        await loginViewModel.onDigitPressed(1, mockBuildContext);
        // Assert
        expect(loginViewModel.dialogMessage, 'Facing technical difficulties');
      }, tags: 'unit');
    });
  });
}
