import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool passwordVisible = false;
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Password is required'),
        FormBuilderValidators.minLength(8,
            errorText: 'Password must be at least 8 digits long'),
      ]),
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        isDense: false,
        labelText: "Password",
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.visibility_off),
        ),
      ),
      name: 'password',
    );
  }
}
