part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordRequested extends ResetPasswordEvent {
  final String code;
  final String email;
  final String password;

  const ResetPasswordRequested({
    required this.code,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [code, email, password];
}
