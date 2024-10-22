import 'package:flutter/material.dart';
import 'package:mobiletesting/pages/login_view_model.dart';

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
