import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/list_users_bloc.dart';
import '../widgets/widgets.dart';

class UsersList extends StatefulWidget {
  const UsersList({
    Key? key,
  }) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListUsersBloc, ListUsersState>(
      builder: (context, state) {
        // debugPrint("state.max: ${state.hasReachedMax}");
        switch (state.status) {
          case ListUsersStatus.failure:
            return const Center(child: Text('failed to fetch users'));
          case ListUsersStatus.success:
            if (state.users.isEmpty) {
              return const Center(child: Text('no users'));
            }
            return GridView.builder(
              // shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.users.length
                    ? const BottomLoader()
                    : UserListItem(user: state.users[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.users.length
                  : state.users.length + 1,
              controller: _scrollController,
            );

          case ListUsersStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    // debugPrint('_onScrollCalled');
    if (_isBottom) {
      context.read<ListUsersBloc>().add(ListUsersFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;

    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
