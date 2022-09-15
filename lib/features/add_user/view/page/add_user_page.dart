import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../_core/di/di.dart';
import '../../bloc/add_user_bloc.dart';
import '../widgets/widgets.dart';

class AddUser extends StatelessWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddUserBloc>(
      create: (context) => di(),
      child: BlocListener<AddUserBloc, AddUserState>(
        listener: (context, state) {
          if (state is AddUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User Successfully Added')),
            );
          }
          if (state is AddUserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed To Added User')),
            );
          }
        },
        child: Center(
          child: AddUserForm(),
        ),
      ),
    );
  }
}

class AddUserForm extends StatelessWidget {
  AddUserForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveValue<double>(context,
          defaultValue: MediaQuery.of(context).size.width,
          valueWhen: [
            Condition.smallerThan(
              name: MOBILE,
              value: MediaQuery.of(context).size.width,
            ),
            Condition.equals(
              name: MOBILE,
              value: MediaQuery.of(context).size.width,
            ),
            Condition.smallerThan(
              name: DESKTOP,
              value: MediaQuery.of(context).size.width * 0.6,
            ),
            Condition.largerThan(
              name: TABLET,
              value: MediaQuery.of(context).size.width * 0.4,
            ),
          ]).value,
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FirstName(),
            const SizedBox(height: 30),
            const LastName(),
            const SizedBox(height: 30),
            const EmailField(),
            const SizedBox(height: 30),
            const PhoneField(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  debugPrint(_formKey.currentState?.value.toString());
                  BlocProvider.of<AddUserBloc>(context).add(AddUserRequested(
                    firstName: _formKey.currentState?.value['firstName'],
                    lastName: _formKey.currentState?.value['lastName'],
                    phone: _formKey.currentState?.value['phone'],
                    email: _formKey.currentState?.value['email'],
                  ));
                } else {
                  debugPrint('validation failed');
                }
              },
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
