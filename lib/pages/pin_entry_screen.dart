// lib/screens/pin_entry_screen.dart

import 'package:flutter/material.dart';

class PinEntryScreen extends StatefulWidget {
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final String correctPin = "123456"; // Set the correct PIN for validation

  void _validatePin() {
    if (_formKey.currentState?.validate() ?? false) {
      final enteredPin = _pinController.text;
      if (_hasSequentialDigits(enteredPin) || _hasRepeatingDigits(enteredPin)){
        _showDialog('Success', 'The PIN is valid');
      } else {
        _showDialog('Error', 'The PIN is invalid.');
      }
    }
  }

  bool _hasSequentialDigits(String pin) {    
    // Check for sequential digits     
    for (int i = 0; i < 5; i++) {       
      if (pin[i].codeUnitAt(0) + 1 == pin[i + 1].codeUnitAt(0)) {         
        return true; // Found sequential digits       
      }     
    }
    return false;   
  }

  bool _hasRepeatingDigits(String pin) {     
    // Check for repeating digits     
    Set<String> digitSet = Set<String>();     
    for (int i = 0; i < pin.length; i++) {       
      if (digitSet.contains(pin[i])) {         
        return true; // Found repeating digit       
      }      
      digitSet.add(pin[i]);     
    }     
    return false;   
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
