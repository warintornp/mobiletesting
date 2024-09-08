// lib/main.dart

import 'package:flutter/material.dart';
import 'pages/pin_entry_screen.dart';
import 'lib.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIN Validator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PinEntryScreen(),
    );
  }
}
