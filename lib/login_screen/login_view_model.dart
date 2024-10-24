// pin_view_model.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobiletesting/home_screen/home_screen.dart';
import 'package:mobiletesting/home_screen/home_view_model.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mobiletesting/secure_storage.dart';
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
    final maxPinLength = 6;
    if (_inputtedPin.length < maxPinLength) {
      _inputtedPin = _inputtedPin + digit.toString();
      notifyListeners();
    }

    if (_inputtedPin.length < 6) {
      return;
    }
    final errorMessage = PinRules().getErrorMessage(_inputtedPin);

    _showErrorDialog(errorMessage ?? "success: Ready to submit pin", context);
    // _isDialogPresent = true;
    // _DislogMessage = "success/fa`";
    // notifyListeners();
  }

  Future<void> onShowErrorDialogButtonPressed(BuildContext context) async {
    _showErrorDialog("Workshop1", context);
  }

  //workshop 1
  void _addPinDigit(int digit) {}

  //workshop 4
  Future<void> _submitPin(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final isAuthenticated = true;

    _isLoading = false;
    notifyListeners();
  }

  //Workshop 7
  void _navigateToUserDetailsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
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
}
