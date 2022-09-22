part of 'request_otp_bloc.dart';

abstract class RequestOtpState extends Equatable {
  const RequestOtpState();

  @override
  List<Object> get props => [];
}

class RequestOtpInitial extends RequestOtpState {}

class RequestOtpLoading extends RequestOtpState {}

class RequestOtpSuccess extends RequestOtpState {}

class RequestOtpFailure extends RequestOtpState {
  final String error;

  const RequestOtpFailure({required this.error});

  @override
  List<Object> get props => [error];
}
