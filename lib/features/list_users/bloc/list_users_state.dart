part of 'list_users_bloc.dart';

enum ListUsersStatus { initial, success, failure }

class ListUsersState extends Equatable {
  final ListUsersStatus status;
  final List<User> users;
  final bool hasReachedMax;

  const ListUsersState({
    this.status = ListUsersStatus.initial,
    this.users = const <User>[],
    this.hasReachedMax = false,
  });

  ListUsersState copyWith({
    ListUsersStatus? status,
    List<User>? users,
    bool? hasReachedMax,
  }) {
    return ListUsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, users, hasReachedMax];
}
