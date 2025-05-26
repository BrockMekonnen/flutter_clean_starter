import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
      decoration: InputDecoration(
        isDense: true,
        labelText: context.tr('registerPage.emailAddress'),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      name: 'email',
    );
  }
}
