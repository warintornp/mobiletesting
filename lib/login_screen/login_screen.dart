import 'package:flutter/material.dart';
import 'package:mobiletesting/login_screen/dot_view.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/pin_grid_view.dart';

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
            if (viewModel.dialogMessage.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showErrorDialog(viewModel.dialogMessage, context, () {
                  viewModel.onDialogClose();
                });
              });
            }

            return Column(
              children: <Widget>[
                Dot(
                  viewModel: viewModel,
                ),
                Text(viewModel.inputtedPin),
                IconButton(
                  onPressed: () {
                    viewModel.onShowErrorDialogButtonPressed(context);
                  },
                  icon: Icon(Icons.error),
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

  //workshop 0
  void _showErrorDialog(String content, BuildContext context,
      void Function() onDialogCloseButtonPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                onDialogCloseButtonPressed();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
