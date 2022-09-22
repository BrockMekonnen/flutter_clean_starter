part of 'request_otp_bloc.dart';

abstract class RequestOtpEvent extends Equatable {
  const RequestOtpEvent();

  @override
  List<Object> get props => [];
}

class OTPRequested extends RequestOtpEvent {
  final String email;
  final String otpFor;

  const OTPRequested({
    required this.email,
    required this.otpFor,
  });

  @override
  List<Object> get props => [email, otpFor];
}
