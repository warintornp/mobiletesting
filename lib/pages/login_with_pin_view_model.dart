// pin_view_model.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/home_screen.dart';
import 'package:mobiletesting/pages/pin_rules.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';

class LoginWithPinViewModel extends ChangeNotifier {
  String _inputtedPin = '';
  bool _isLoading = false;
  // bool _shouldNavigateToUserDetailsScreen = false;
  // Map<String, dynamic>? _userDetails = {};
  // String _errorDialogMessage = '';

  final UserService userService;
  final SortOrder keyPadsortOrder;

  LoginWithPinViewModel(this.userService, this.keyPadsortOrder);

  String get inputtedPin => _inputtedPin;
  bool get isLoading => _isLoading;
  // bool get shouldNavigateToUserDetailsScreen =>
  //     _shouldNavigateToUserDetailsScreen;
  // Map<String, dynamic>? get userDetails => _userDetails;
  // String get errorDialogMessage => _errorDialogMessage;

  void onDigitPressed(int digit, BuildContext context) {
    addPinDigit(digit);

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

  void addPinDigit(int digit) {
    if (_inputtedPin.length < 6) {
      _inputtedPin = _inputtedPin + digit.toString();
      notifyListeners();
    }
  }

  Future<void> _submitPin(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 4));
    final userDetails = await userService.fetchUserDetails2(_inputtedPin);

    _isLoading = false;
    notifyListeners();
    if (userDetails != null && userDetails.isNotEmpty && context.mounted) {
      _navigateToUserDetailsScreen(userDetails, context);
    } else {
      if (context.mounted) {
        _showErrorDialog(
            'Invalid pin or network issue. please try again.', context);
      }
    }
  }

  void _navigateToUserDetailsScreen(
      Map<String, dynamic> userDetails, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(userDetails: userDetails),
      ),
    );
  }

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
