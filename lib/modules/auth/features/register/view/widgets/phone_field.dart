import 'package:easy_localization/easy_localization.dart';
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
      name: 'phone',
      keyboardType: TextInputType.phone,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        (value) {
          String pattern = r'^\+?\d{1,4}?[-.\s]?\(?\d{1,4}?\)?[-.\s]?\d{3,15}$';
          RegExp regExp = RegExp(pattern);
          if (!regExp.hasMatch(value!)) {
            return context.tr('registerPage.validPhoneNumberErrorMessage');
          }
          return null;
        }
      ]),
      decoration: InputDecoration(
        isDense: true,
        labelText: context.tr('registerPage.phoneNumber'),
        hintText: context.tr('registerPage.phoneNumberHint'),
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
