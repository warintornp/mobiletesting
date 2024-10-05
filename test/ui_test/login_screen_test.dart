import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/login_screen.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:provider/provider.dart';

//Widget testing should validate only app state changes.
//snapshot testing should validate the UI changes.
void main() {
  testWidgets('Valid PIN and successful API call with dialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginViewModel(UserService(), SortOrder.ascending),
          child: const LoginScreen(),
        ),
      ),
    );
  }, tags: 'widget');

  testWidgets(
      'Invalid (FE rule) PIN with dialog', (WidgetTester tester) async {},
      tags: 'widget');

  testWidgets(
      'Invalid (BE rule) PIN with dialog', (WidgetTester tester) async {},
      tags: 'widget');
}
