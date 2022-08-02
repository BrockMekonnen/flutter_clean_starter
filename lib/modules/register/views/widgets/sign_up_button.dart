import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
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
            debugPrint(formKey.currentState?.value.toString());
          } else {
            debugPrint(formKey.currentState?.value.toString());
            debugPrint('validation failed');
          }
        },
        child: const Text(
          "Sign Up",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
