import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.isPasswordVisible,
  });

  final bool isPasswordVisible;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(8,
            errorText: context.tr('loginPage.passwordMinLengthErrorMessage')),
        (value) {
          String pattern = r'(?=.*?[#?!@$%^&*-])';
          RegExp regExp = RegExp(pattern);
          if (!regExp.hasMatch(value!)) {
            return context.tr('loginPage.passwordSpecialCharacterErrorMessage');
          }
          return null;
        }
      ]),
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        isDense: true,
        labelText: context.tr('registerPage.password'),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
