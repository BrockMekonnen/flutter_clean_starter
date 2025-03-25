import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
    Key? key,
    required this.formKey,
    required this.isPasswordVisible,
  }) : super(key: key);

  final bool isPasswordVisible;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        (value) {
          debugPrint(
              ' password: ${formKey.currentState?.fields['password']?.value == value}');
          debugPrint(' confirmPassword: $value');
          if (formKey.currentState?.fields['password']?.value != value) {
            return 'password do not match';
          }
          return null;
        }
      ]),
      obscureText: !isPasswordVisible,
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Confirm",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      name: 'confirmPassword',
    );
  }
}
