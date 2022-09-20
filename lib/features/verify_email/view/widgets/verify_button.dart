import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../auth/bloc/auth_bloc.dart';
import '../../bloc/verify_email_bloc.dart';

class VerifyButton extends StatelessWidget {
  const VerifyButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 15),
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(52)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
            ),
            onPressed: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                // debugPrint(formKey.currentState?.value['otpCode'].toString());
                // debugPrint(state.user.email);
                BlocProvider.of<VerifyEmailBloc>(context)
                    .add(VerifyEmailRequested(
                  email: state.user.email,
                  code: formKey.currentState!.value['otpCode'].toString(),
                ));
              } else {
                debugPrint('OTP Validation Error');
              }
            },
            child: const Text(
              "Verify",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
