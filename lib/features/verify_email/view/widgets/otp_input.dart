// Create an input widget that takes only one digit
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 52,
      width: 120,
      child: FormBuilderTextField(
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.integer(),
        ]),
        autofocus: true,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        name: 'otpCode',
      ),
    );
  }
}
