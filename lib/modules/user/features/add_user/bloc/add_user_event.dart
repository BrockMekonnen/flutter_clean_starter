part of 'add_user_bloc.dart';

abstract class AddUserEvent extends Equatable {
  const AddUserEvent();

  @override
  List<Object> get props => [];
}

class AddUserRequested extends AddUserEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;

  const AddUserRequested({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        phone,
        email,
      ];
}
