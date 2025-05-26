import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.tr('loginPage.dontHaveAccount')),
        TextButton(
          onPressed: () => context.go("/register"),
          child: Text(context.tr('loginPage.signUp')),
        ),
      ],
    );
  }
}
