import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../modules/user/domain/user.dart';
import '../../../modules/user/domain/user_repository.dart';

part 'list_users_event.dart';
part 'list_users_state.dart';

class ListUsersBloc extends Bloc<ListUsersEvent, ListUsersState> {
  final UserRepository _userRepository;

  ListUsersBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const ListUsersState()) {
    on<ListUsersFetched>(_onUsersFetched);
  }

  Future<void> _onUsersFetched(
      ListUsersFetched event, Emitter<ListUsersState> emit) async {
    int limit = 10;
    if (state.hasReachedMax) return;
    try {
      if (state.status == ListUsersStatus.initial) {
        final users = await _userRepository.fetchUsers();
        return emit(state.copyWith(
          status: ListUsersStatus.success,
          users: users,
          hasReachedMax: users.length < limit,
        ));
      }
      final page = (state.users.length / limit).ceil() + 1;
      final users = await _userRepository.fetchUsers(page, limit);
      users.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ListUsersStatus.success,
                users: List.of(state.users)..addAll(users),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ListUsersStatus.failure));
    }
  }
}
