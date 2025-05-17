import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../../_shared/widgets/show_toast_notification.dart';
import '../../bloc/register_bloc.dart';
import '../widgets/widgets.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          CustomToast.showErrorNotification(
            title: "Registration Failed",
            description: state.error,
          );
        } else if (state is RegisterSuccess) {
          CustomToast.showSuccessNotification(
            title: "Registration Successful",
            description: "Your account has been successfully created!",
          );
          context.go('/login');
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
          width: isMobile ? null : 500,
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
                  FlutterLogo(size: 50),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      context.tr('registerPage.signUp'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
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
                      Text(
                        context.tr('registerPage.showPassword'),
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  FormBuilderCheckbox(
                    name: 'iAgree',
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                    ),
                    title: Text(context.tr('registerPage.iAgreeToTermCondition')),
                  ),
                  const SizedBox(height: 30),
                  SignUpButton(formKey: _formKey),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.tr('registerPage.alreadyHaveAccount')),
                      TextButton(
                        onPressed: () => context.go("/login"),
                        child: Text(context.tr('registerPage.signIn')),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
