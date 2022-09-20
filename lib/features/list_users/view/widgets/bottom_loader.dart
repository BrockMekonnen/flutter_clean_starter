import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/list_users_bloc.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPrint('bottom loader called');
    return BlocBuilder<ListUsersBloc, ListUsersState>(
      builder: (context, state) {
        debugPrint('state.status: ${state.status}');
        if (state.status == ListUsersStatus.success) {
          BlocProvider.of<ListUsersBloc>(context).add(ListUsersFetched());
        }
        return const Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 1.5),
          ),
        );
      },
    );
  }
}
