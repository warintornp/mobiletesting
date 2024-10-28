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
    group('onDeleteButtonPressed', () {
      test(
          'given inputted pin is not empty when delete button is click then last digit from inputtedPin will be removed',
          () {},
          tags: 'unit');
    });

    group('navigation', () {});
  });
}
