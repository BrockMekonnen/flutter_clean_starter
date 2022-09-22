import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../_core/di/di.dart';
import '../../../_core/router/router.dart';
import '../../../_shared/bloc/request_otp/request_otp_bloc.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestOtpBloc>(
      create: (context) => di(),
      child: Scaffold(
        body: ForgetPasswordBody(),
      ),
    );
  }
}

class ForgetPasswordBody extends StatelessWidget {
  ForgetPasswordBody({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return BlocListener<RequestOtpBloc, RequestOtpState>(
      listener: (context, state) {
        if (state is RequestOtpSuccess) {
          // debugPrint('email: ${_formKey.currentState?.value['email']}');
          context.goNamed(resetPasswordRouteName, extra: <String, String>{
            'email': _formKey.currentState?.value['email']
          });
        } else if (state is RequestOtpFailure) {
          debugPrint(state.error);
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
                SizedBox(
                  height: 160,
                  child: ClipRRect(
                    child: SvgPicture.asset("assets/svg/new_email.svg"),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text(
                    'Update Your Password',
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
                FormBuilderTextField(
                  decoration: const InputDecoration(
                    labelText: "Email",
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
                  name: 'email',
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
                    onPressed: () async {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        BlocProvider.of<RequestOtpBloc>(context)
                            .add(OTPRequested(
                          email: _formKey.currentState?.value['email'],
                          otpFor: 'Forget',
                        ));
                      } else {
                        debugPrint("Forget Password Validation Error");
                      }
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.goNamed(loginRouteName);
                        },
                        child: const Text("Remember Your Password?"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
