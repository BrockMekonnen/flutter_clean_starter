import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../_core/router/router.dart';
import '../widgets/widgets.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
      width: isMobile ? null : 448,
      decoration: isMobile
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
              border: Border.all(width: 0.7, color: const Color(0xffdadce0)),
            ),
      child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 30),
              ResponsiveRowColumn(
                columnSpacing: 24,
                rowSpacing: 8,
                layout: isMobile
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: const [
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: FirstName(),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: LastName(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const PhoneField(),
              const SizedBox(height: 24),
              const EmailField(),
              const SizedBox(height: 24),
              ResponsiveRowColumn(
                columnSpacing: 24,
                rowSpacing: 8,
                layout: isMobile
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: PasswordField(
                      isPasswordVisible: _isPasswordVisible,
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: ConfirmPasswordField(
                      formKey: _formKey,
                      isPasswordVisible: _isPasswordVisible,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(
                    value: _isPasswordVisible,
                    onChanged: (value) {
                      setState(() {
                        _isPasswordVisible = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Show Password',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              const SizedBox(height: 24),
              FormBuilderCheckbox(
                name: 'isTermAndConditionAgreed',
                title: const Text('I Agree to Term and Condition'),
              ),
              const SizedBox(height: 30),
              SignUpButton(formKey: _formKey),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Have Account?'),
                  TextButton(
                    onPressed: () {
                      context.goNamed(loginRouteName);
                    },
                    child: const Text("Sign In"),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
