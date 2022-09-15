part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegistrationRequested extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final bool isTermAndConditionAgreed;

  const RegistrationRequested({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.isTermAndConditionAgreed,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        phone,
        email,
        password,
        isTermAndConditionAgreed,
      ];
}