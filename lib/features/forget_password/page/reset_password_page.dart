import 'package:clean_flutter/_core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../_core/di/di.dart';
import '../bloc/reset_password_bloc.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordBloc>(
      create: (context) => di(),
      child: Scaffold(
        body: ResetPasswordBody(
          email: email,
        ),
      ),
    );
  }
}

class ResetPasswordBody extends StatelessWidget {
  ResetPasswordBody({
    Key? key,
    required this.email,
  }) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final String email;

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          context.goNamed(loginRouteName);
        }
        if (state is ResetPasswordFailure) {
          debugPrint(state.message);
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
          width: isMobile ? null : 448,
          decoration: isMobile
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                  border:
                      Border.all(width: 0.7, color: const Color(0xffdadce0)),
                ),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text(
                    'Reset Your Password',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                  child: Text(
                    'Enter your email address and select Send Email.',
                    textAlign: TextAlign.center,
                  ),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: [
                    const Text(
                      'Code',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: FormBuilderTextField(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.integer(),
                          FormBuilderValidators.equalLength(6)
                        ]),
                        autofocus: true,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: const InputDecoration(
                            prefixText: 'RP -',
                            prefixStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            isDense: true,
                            errorMaxLines: 3,
                            border: OutlineInputBorder(),
                            counterText: '',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 20.0)),
                        name: 'code',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                FormBuilderTextField(
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Password is required'),
                    FormBuilderValidators.minLength(8,
                        errorText: 'Password must be at least 8 digits long'),
                    (value) {
                      String pattern = r'(?=.*?[#?!@$%^&*-])';
                      RegExp regExp = RegExp(pattern);
                      if (!regExp.hasMatch(value!)) {
                        return 'passwords must have at least one special character';
                      }
                      return null;
                    }
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "New Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFdadce0), width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFdadce0), width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  name: 'password',
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    (value) {
                      debugPrint(
                          ' password: ${_formKey.currentState?.fields['password']?.value == value}');
                      debugPrint(' confirmPassword: ');
                      if (_formKey.currentState?.fields['password']?.value !=
                          value) {
                        return 'password do not match';
                      }
                      return null;
                    }
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFdadce0), width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFdadce0), width: 0.8),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  name: 'confirmPassword',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 30, 50, 15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(
                            const Size.fromHeight(52)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)))),
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        debugPrint("${_formKey.currentState?.value}");
                        debugPrint("");
                        BlocProvider.of<ResetPasswordBloc>(context)
                            .add(ResetPasswordRequested(
                          code: _formKey.currentState?.value['code'],
                          email: email,
                          password: _formKey.currentState?.value['password'],
                        ));
                      } else {
                        debugPrint("Forget Password Validation Error");
                      }
                    },
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
