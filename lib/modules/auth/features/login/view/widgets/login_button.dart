import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(56)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)))),
        onPressed: () {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            // debugPrint(formKey.currentState?.value['email'].toString());
            // debugPrint(formKey.currentState?.value['password'].toString());
            BlocProvider.of<LoginBloc>(context).add(LoginSubmitted(
              email: formKey.currentState?.value['email'],
              password: formKey.currentState?.value['password'],
            ));
          } else {
            debugPrint(formKey.currentState?.value.toString());
            debugPrint('validation failed');
          }
        },
        child: const Text(
          "Sign In",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
