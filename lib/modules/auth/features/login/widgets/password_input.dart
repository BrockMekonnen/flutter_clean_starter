import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required this.isPasswordVisible,
    required this.changePasswordVisibility,
  });

  final bool isPasswordVisible;
  final Function changePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      obscureText: !isPasswordVisible,
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
      decoration: InputDecoration(
        // isDense: true,
        labelText: context.tr('loginPage.password'),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        suffixIcon: IconButton(
          onPressed: () => changePasswordVisibility(),
          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
