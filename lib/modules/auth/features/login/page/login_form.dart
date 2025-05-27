import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/app_router.dart';
import '../../../../../_shared/widgets/show_toast_notification.dart';
import '../bloc/login_bloc.dart';
import '../widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

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
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          CustomToast.showErrorNotification(
            title: "Login Error",
            description: state.error,
          );
        }
        if (state is LoginSuccess) {
          context.go(firstNavRoute());
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: !isMobile ? Theme.of(context).cardColor : null,
            border:
                !isMobile ? Border.all(width: 0.7, color: const Color(0xffdadce0)) : null,
          ),
          child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlutterLogo(size: 50),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      context.tr("loginPage.signIn"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
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
