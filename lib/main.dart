import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/login_screen.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/login_service.dart';
import 'package:provider/provider.dart';

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
      ),
      home: ChangeNotifierProvider(
        create: (_) => LoginViewModel(LoginService(),
            Random().nextBool() ? SortOrder.ascending : SortOrder.descending),
        child: LoginScreen(),
      ),
    );
  }
}
