import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.isPasswordVisible,
  }) : super(key: key);

  final bool isPasswordVisible;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Password is required'),
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
      obscureText: !isPasswordVisible,
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Password",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      name: 'password',
    );
  }
}
