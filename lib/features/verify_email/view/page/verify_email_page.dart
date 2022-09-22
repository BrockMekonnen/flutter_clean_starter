import 'package:clean_flutter/_shared/bloc/request_otp/request_otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../_core/di/di.dart';
import '../../bloc/verify_email_bloc.dart';
import 'verify_email_form.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerifyEmailBloc>(create: (context) => di()),
        BlocProvider<RequestOtpBloc>(create: (context) => di()),
      ],
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: const VerifyEmailForm(),
        ),
      ),
    );
  }
}
