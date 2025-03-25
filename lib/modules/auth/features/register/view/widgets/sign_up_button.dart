import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../bloc/register_bloc.dart';

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
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state is RegisterLoading) {
            return const CircularProgressIndicator();
          }
          if (state is RegisterSuccess) {

          }
          return ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                minimumSize:
                    MaterialStateProperty.all(const Size.fromHeight(56)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)))),
            onPressed: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                // debugPrint(formKey.currentState?.value.toString());
                BlocProvider.of<RegisterBloc>(context)
                    .add(RegistrationRequested(
                  firstName: formKey.currentState?.value['firstName'],
                  lastName: formKey.currentState?.value['lastName'],
                  phone: formKey.currentState?.value['phone'],
                  email: formKey.currentState?.value['email'],
                  password: formKey.currentState?.value['password'],
                  isTermAndConditionAgreed:
                      formKey.currentState?.value['isTermAndConditionAgreed'],
                ));
              } else {
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
          );
        },
      ),
    );
  }
}
