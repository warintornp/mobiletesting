// pin_page.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mobiletesting/pages/pin_grid_view.dart';
import 'package:mobiletesting/pages/sort_order.dart';
import 'package:mobiletesting/user_service.dart';

import 'package:provider/provider.dart';

//MVVM with ChangeNotifierProvider
//the alternative of mvvm is delegation pattern with mixin https://betterprogramming.pub/how-to-implement-the-delegation-design-pattern-in-dart-d782de77c886
class LoginScreen extends StatelessWidget {
  static const routeName = 'pin-page';

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(UserService(),
          Random().nextBool() ? SortOrder.ascending : SortOrder.descending),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enter PIN'),
        ),
        body: Center(
          child: Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              print(viewModel.inputtedPin);
              return Column(
                children: <Widget>[
                  const Icon(
                    Icons.add,
                    size: 50.0,
                    color: Colors.green,
                  ),
                  Text(viewModel.inputtedPin),
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List<int>.generate(6, (i) => i + 1).map<Widget>(
                        (number) => createCircle(number, viewModel),
                      )
                    ],
                  ),
                  const SizedBox(height: 50.0),
                  viewModel.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.orange,
                        )
                      : Expanded(
                          child: PinGridView(
                              sortOrder: viewModel.keyPadsortOrder,
                              deleteButtonOnPressed:
                                  viewModel.onDeleteButtonPressed,
                              numberButtonOnPressed: (pressedDigit) => {
                                    viewModel.onDigitPressed(
                                        pressedDigit, context)
                                  }),
                        ),

//
                ],
              );
            },
          ),
        ),
      ),
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
