import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FirstName extends StatelessWidget {
  const FirstName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'First Name is required'),
        FormBuilderValidators.minLength(3,
            errorText: 'Name must be longer than 2 characters'),
      ]),
      decoration: const InputDecoration(
        isDense: true,
        labelText: "First Name",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      name: 'firstName',
    );
  }
}
