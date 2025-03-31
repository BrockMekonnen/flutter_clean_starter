import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Password is required'),
        (value) {
          String pattern = r'^\+?\d{1,4}?[-.\s]?\(?\d{1,4}?\)?[-.\s]?\d{3,15}$';
          RegExp regExp = RegExp(pattern);
          if (!regExp.hasMatch(value!)) {
            return 'Please enter valid phone number';
          }
          return null;
        }
      ]),
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Phone",
        hintText: "Enter your phone number (e.g., +1 123-456-7890)",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      keyboardType: TextInputType.phone,
      name: 'phone',
    );
  }
}
