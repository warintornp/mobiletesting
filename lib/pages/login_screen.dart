// pin_page.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mobiletesting/pages/pin_grid_view.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/login_service.dart';

import 'package:provider/provider.dart';

//MVVM with ChangeNotifierProvider
//the alternative of mvvm is delegation pattern with mixin https://betterprogramming.pub/how-to-implement-the-delegation-design-pattern-in-dart-d782de77c886
class LoginScreen extends StatelessWidget {
  static const routeName = 'pin-page';

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter PIN'),
      ),
      body: Center(
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: <Widget>[
                Dot(
                  viewModel: viewModel,
                ),
                viewModel.isLoading
                    ? const CircularProgressIndicator(
                        color: Color.fromARGB(255, 37, 9, 131),
                      )
                    : pinGridViewWidget(viewModel, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget pinGridViewWidget(LoginViewModel viewModel, BuildContext context) {
    return Expanded(
      child: PinGridView(
          sortOrder: viewModel.keyPadsortOrder,
          deleteButtonOnPressed: viewModel.onDeleteButtonPressed,
          numberButtonOnPressed: (pressedDigit) =>
              {viewModel.onDigitPressed(pressedDigit, context)}),
    );
  }
}

class Dot extends StatelessWidget {
  final LoginViewModel viewModel;
  const Dot({super.key, required this.viewModel});

  @override
  Widget build(Object context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ...List<int>.generate(6, (i) => i + 1).map<Widget>(
          (number) => createCircle(number, viewModel),
        )
      ]),
    );
  }

  Widget createCircle(int index, LoginViewModel viewModel) {
    return Container(
      width: 15.0,
      height: 15.0,
      decoration: index <= viewModel.inputtedPin.length
          ? const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
            )
          : BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.orange,
                width: 2.0,
              ),
            ),
    );
  }
}
