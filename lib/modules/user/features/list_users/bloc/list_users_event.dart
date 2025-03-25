part of 'list_users_bloc.dart';

abstract class ListUsersEvent extends Equatable {
  const ListUsersEvent();
  @override
  List<Object> get props => [];
}

class ListUsersFetched extends ListUsersEvent {}
