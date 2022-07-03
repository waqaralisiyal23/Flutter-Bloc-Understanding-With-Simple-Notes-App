import 'package:bloclearningwithsimplenotesapp/res/constants.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordTextField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: true,
      obscuringCharacter: '◉',
      decoration: const InputDecoration(
        hintText: Constants.enterYourPasswordHere,
      ),
    );
  }
}
