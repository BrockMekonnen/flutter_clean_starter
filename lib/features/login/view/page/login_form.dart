import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../bloc/login_bloc.dart';
import '../widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isPasswordVisible = false;

  void changePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.error)),
            );
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
          width: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
            border: Border.all(width: 0.7, color: const Color(0xffdadce0)),
          ),
          child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const EmailInput(),
                  const SizedBox(height: 15),
                  PasswordInput(
                    changePasswordVisibility: changePasswordVisibility,
                    isPasswordVisible: isPasswordVisible,
                  ),
                  const SizedBox(height: 10),
                  const ForgetPasswordButton(),
                  const SizedBox(height: 40),
                  LoginButton(formKey: _formKey),
                  const SizedBox(height: 40),
                  const SignUpButton()
                ],
              )),
        ),
      ),
    );
  }
}
