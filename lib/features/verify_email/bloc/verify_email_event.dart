part of 'verify_email_bloc.dart';

abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object> get props => [];
}

class VerifyEmailRequested extends VerifyEmailEvent {
  final String code;
  final String email;

  const VerifyEmailRequested({
    required this.code,
    required this.email,
  });

  @override
  List<Object> get props => [code, email];
}


