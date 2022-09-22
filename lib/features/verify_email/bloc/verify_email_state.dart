part of 'verify_email_bloc.dart';

abstract class VerifyEmailState extends Equatable {
  const VerifyEmailState();
  
  @override
  List<Object> get props => [];
}

class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccess extends VerifyEmailState {}

class VerifyEmailFailure extends VerifyEmailState {
  final String error;

  const VerifyEmailFailure({required this.error});

  @override
  List<Object> get props => [error];
}
