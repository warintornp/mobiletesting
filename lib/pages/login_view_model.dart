// pin_view_model.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/home_screen.dart';
import 'package:mobiletesting/pages/home_view_model.dart';
import 'package:mobiletesting/pages/pin_rules.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/login_service.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  String _inputtedPin = '';
  bool _isLoading = false;

  final LoginService loginService;
  final SortOrder keyPadsortOrder;

  LoginViewModel(this.loginService, this.keyPadsortOrder);

  String get inputtedPin => _inputtedPin;
  bool get isLoading => _isLoading;

  //workshop 1
  void onDigitPressed(int digit, BuildContext context) {
    _addPinDigit(digit);

    if (_inputtedPin.length < 6) {
      return;
    }

    final errorMessage = PinRules().getErrorMessage(_inputtedPin);
    //hidden issue#1: failedMessage = null
    if (errorMessage != null) {
      _showErrorDialog(errorMessage, context);
    } else {
      _submitPin(context);
    }
  }

  //workshop 1
  void _addPinDigit(int digit) {
    if (_inputtedPin.length < 6) {
      _inputtedPin = _inputtedPin + digit.toString();
      notifyListeners();
    }
  }

  ////workshop 4
  Future<void> _submitPin(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 4));
    final isAuthenticated = await loginService.authenticate(_inputtedPin);

    _isLoading = false;
    notifyListeners();
    // if (isAuthenticated != null && isAuthenticated.isNotEmpty && context.mounted) {
    if (isAuthenticated && context.mounted) {
      _navigateToUserDetailsScreen(context);
    } else {
      if (context.mounted) {
        _showErrorDialog(
            'Invalid pin or network issue. please try again.', context);
      }
    }
  }

  //Workshop 7
  void _navigateToUserDetailsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => HomeViewModel(userService: UserService()),
          child: HomeScreen(),
        ),
      ),
    );
  }

  //workshop 0
  void _showErrorDialog(String content, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  //workshop 2
  void onDeleteButtonPressed() {
    if (_inputtedPin.isNotEmpty) {
      _inputtedPin = _inputtedPin.substring(0, _inputtedPin.length - 1);
      notifyListeners();
    }
  }

  // Future<void> submitPin() async {
  //   if (_inputtedPin.length == 6) {
  //     _isLoading = true;
  //     notifyListeners();

  //     // Simulate a delay for submitting the pin
  //     await Future.delayed(Duration(seconds: 2));

  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
