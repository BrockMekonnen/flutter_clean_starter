import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
    super.key,
    required this.formKey,
    required this.isPasswordVisible,
  });

  final bool isPasswordVisible;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'confirmPassword',
      obscureText: !isPasswordVisible,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        (value) {
          if (formKey.currentState?.fields['password']?.value != value) {
            return context.tr('registerPage.passwordDoNotMatch');
          }
          return null;
        }
      ]),
      decoration: InputDecoration(
        isDense: true,
        labelText: context.tr('registerPage.confirm'),
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
