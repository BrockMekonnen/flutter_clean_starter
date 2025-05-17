import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.formKey});

  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          bool isLoading = state is LoginLoading;
          return FilledButton(
            style: FilledButton.styleFrom(minimumSize: Size.fromHeight(50)),
            onPressed: !isLoading
                ? () {
                    if (formKey.currentState?.saveAndValidate() ?? false) {
                      BlocProvider.of<LoginBloc>(context).add(LoginSubmitted(
                        email: formKey.currentState?.value['email'],
                        password: formKey.currentState?.value['password'],
                      ));
                    } else {
                      debugPrint(formKey.currentState?.value.toString());
                      debugPrint('validation failed');
                    }
                  }
                : null,
            child: isLoading
                ? CircularProgressIndicator()
                : Text(context.tr("loginPage.signIn")),
          );
        },
      ),
    );
  }
}
