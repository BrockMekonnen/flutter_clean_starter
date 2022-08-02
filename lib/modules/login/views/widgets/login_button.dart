import 'package:clean_flutter/_core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState?.saveAndValidate() ?? false) {
          context.goNamed(homeRouteName);
          debugPrint(formKey.currentState?.value.toString());
        } else {
          debugPrint(formKey.currentState?.value.toString());
          debugPrint('validation failed');
        }
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(56)),
      ),
      child: const Text(
        "Log In",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }
}
