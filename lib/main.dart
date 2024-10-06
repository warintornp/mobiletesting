// lib/main.dart

import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIN Validator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RobotoMono'
      ),
      // home: LoginWithPinScreen(userService: UserService()),
      home: const LoginScreen(),
    );
  }
}
