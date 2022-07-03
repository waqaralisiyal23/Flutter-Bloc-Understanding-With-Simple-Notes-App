import 'package:bloclearningwithsimplenotesapp/dialogs/generic_dialog.dart';
import 'package:bloclearningwithsimplenotesapp/res/constants.dart';
import 'package:flutter/material.dart';

typedef OnLoginTapped = void Function(String email, String password);

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLoginTapped onLoginTapped;

  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final email = emailController.text;
        final password = passwordController.text;
        if (email.isEmpty || password.isEmpty) {
          await showGenericDialog<bool>(
            context: context,
            title: Constants.emailOrPasswordEmptyDialogTitle,
            content: Constants.emailOrPasswordEmptyDescription,
            optionsBuilder: () => {
              Constants.ok: true,
            },
          );
        } else {
          onLoginTapped(
            email,
            password,
          );
        }
      },
      child: const Text(Constants.login),
    );
  }
}
