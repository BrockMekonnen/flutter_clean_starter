import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../bloc/register_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.formKey,
  });

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
          if (state is RegisterSuccess) {}
          return FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                // debugPrint(formKey.currentState?.value.toString());
                BlocProvider.of<RegisterBloc>(context).add(RegistrationRequested(
                  firstName: formKey.currentState?.value['firstName'],
                  lastName: formKey.currentState?.value['lastName'],
                  phone: formKey.currentState?.value['phone'],
                  email: formKey.currentState?.value['email'],
                  password: formKey.currentState?.value['password'],
                  iAgree: formKey.currentState?.value['iAgree'],
                ));
              } else {
                debugPrint('validation failed');
              }
            },
            child: const Text("Sign Up"),
          );
        },
      ),
    );
  }
}
