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
  String _dialogMessage = '';

  final LoginService loginService;
  final SortOrder keyPadsortOrder;
  final PinRules pinRules;

  LoginViewModel(this.loginService, this.keyPadsortOrder, this.pinRules);

  String get inputtedPin => _inputtedPin;
  bool get isLoading => _isLoading;
  String get dialogMessage => _dialogMessage;

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

    final errorMessage = pinRules.getErrorMessage(_inputtedPin);
    _dialogMessage = errorMessage ?? "Ready to submit pin.";
    notifyListeners();
  }

  Future<void> onShowErrorDialogButtonPressed(BuildContext context) async {
    // _showErrorDialog("Workshop1", context);
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

  //workshop 2
  void onDeleteButtonPressed() {
    if (_inputtedPin.isNotEmpty) {
      _inputtedPin = _inputtedPin.substring(0, _inputtedPin.length - 1);
      notifyListeners();
    }
  }

  void onDialogClose() {
    _dialogMessage = "";
    // notifyListeners();
  }
}
