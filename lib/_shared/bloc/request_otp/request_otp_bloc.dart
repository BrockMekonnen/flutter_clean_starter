import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../modules/auth/domain/auth_repository.dart';

part 'request_otp_event.dart';
part 'request_otp_state.dart';

class RequestOtpBloc extends Bloc<RequestOtpEvent, RequestOtpState> {
  final AuthRepository _authRepository;

  RequestOtpBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(RequestOtpInitial()) {
    on<OTPRequested>(_resendOTPRequested);
  }

  Future<void> _resendOTPRequested(
    OTPRequested event,
    Emitter<RequestOtpState> emit,
  ) async {
    emit(RequestOtpLoading());

    try {
      await _authRepository.requestOTP(
          email: event.email, otpFor: event.otpFor);
      emit(RequestOtpSuccess());
    } catch (error) {
      emit(const RequestOtpFailure(error: 'Error Requesting OTP'));
    }
  }
}
