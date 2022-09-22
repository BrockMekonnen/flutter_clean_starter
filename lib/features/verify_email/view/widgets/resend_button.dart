import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../_shared/bloc/request_otp/request_otp_bloc.dart';
import '../../../auth/bloc/auth_bloc.dart';

class ResendButton extends StatelessWidget {
  const ResendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // debugPrint(state.user.email);
                  BlocProvider.of<RequestOtpBloc>(context).add(OTPRequested(
                      email: state.user.email, otpFor: 'Verification'));
                },
                child: const Text("Resend"),
              ),
            ],
          ),
        );
      },
    );
  }
}
