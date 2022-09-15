import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../_core/di/di.dart';
import '../../bloc/list_users_bloc.dart';
import 'users_list.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListUsersBloc>(
      create: (context) => di(),
      child: const UsersList(),
    );
  }
}
