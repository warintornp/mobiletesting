// lib/screens/pin_entry_screen.dart

import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/home_screen.dart';
import 'package:mobiletesting/user_service.dart';
import '../pin_validator.dart';

class PinEntryScreen extends StatefulWidget {
  final UserService userService;
  PinEntryScreen({required this.userService});
  
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PinValidator _pinValidator = PinValidator();
  
  Future<void> _validatePin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final enteredPin = _pinController.text;
      
      if (_pinValidator.validatePin(enteredPin)){
        // Fetch user details from API
        final userDetails = await widget.userService.fetchUserDetails(enteredPin);

        if (userDetails != null) {
          _navigateToUserDetailsScreen(userDetails);
        } else {
          _showDialog('Error', 'Failed to fetch user details.');
        }
      } else {
        _showDialog('Error', 'The PIN is invalid.');
      }
    }
  }

  void _showDialog(String title, String content) {
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
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

void _navigateToUserDetailsScreen(Map<String, dynamic> userDetails) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(userDetails: userDetails),
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
