// lib/screens/pin_entry_screen.dart

import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/user_details_screen.dart';
import 'package:mobiletesting/user_service.dart';
import '../pin_validator.dart';

class PinEntryScreen extends StatefulWidget {
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PinValidator _pinValidator = PinValidator();
  late UserService _userService;
  String? _dialogTitle;
  String? _dialogContent;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
  }


  Future<void> _validatePin() async{
    if (_formKey.currentState?.validate() ?? false) {
      final enteredPin = _pinController.text;
      
      // final userDetails = await _userService.fetchUserDetails(enteredPin);

      if (_pinValidator.validatePin(enteredPin)){
        _showDialog('Success', 'The PIN is valid', '');
      } else {
        _showDialog('Error', 'The PIN is invalid.', '');
      } 
    }
  }

  void _showDialog(String title, String content, String userDetails) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if(userDetails == '') { 
                  _navigateToUserDetailsScreen('Test');
                  }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

void _navigateToUserDetailsScreen(String userDetails) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserDetailsScreen(userDetails: userDetails),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter 6-Digit PIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter PIN',
                  border: OutlineInputBorder(),
                ),
                maxLength: 6,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a PIN';
                  } else if (value.length != 6) {
                    return 'PIN must be 6 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validatePin,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
