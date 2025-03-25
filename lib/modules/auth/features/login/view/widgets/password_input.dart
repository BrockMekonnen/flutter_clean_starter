import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    required this.isPasswordVisible,
    required this.changePasswordVisibility,
  }) : super(key: key);

  final bool isPasswordVisible;
  final Function changePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
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
      decoration: InputDecoration(
        isDense: true,
        labelText: "Password",
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            changePasswordVisibility();
          },
          icon:
              Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      name: 'password',
    );
  }
}
