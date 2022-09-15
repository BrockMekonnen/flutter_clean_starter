import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../_core/di/di.dart';
import '../../bloc/register_bloc.dart';
import 'registration_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: BlocProvider<RegisterBloc>(
            create: (context) => di(),
            child: const RegistrationForm(),
          ),
        ),
      ),
    );
  }
}
