part of 'add_user_bloc.dart';

abstract class AddUserState extends Equatable {
  const AddUserState();

  @override
  List<Object> get props => [];
}

class AddUserInitial extends AddUserState {}

class AddUserLoading extends AddUserState {}

class AddUserSuccess extends AddUserState {}

class AddUserFailure extends AddUserState {
  final String error;

  const AddUserFailure({required this.error});

  @override
  List<Object> get props => [error];
}
