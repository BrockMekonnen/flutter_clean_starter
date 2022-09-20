import 'package:bloc/bloc.dart';
import 'package:clean_flutter/modules/auth/domain/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../modules/user/domain/user_repository.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final AuthRepository _authRepository;
  VerifyEmailBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(VerifyEmailInitial()) {
    on<VerifyEmailRequested>(_verifyEmailRequested);
    on<ResendOTPRequested>(_resendOTPRequested);
  }

  Future<void> _resendOTPRequested(
    ResendOTPRequested event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(ResendOTPLoading());

    try {
      await _authRepository.requestOTP(email: event.email);
      emit(ResendOTPSuccess());
    } catch (error) {
      emit(const ResendOTPFailure(error: 'Error Requesting OTP'));
    }
  }

  Future<void> _verifyEmailRequested(
    VerifyEmailRequested event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(VerifyEmailLoading());

    try {
      await _authRepository.verifyEmail(code: event.code, email: event.email);
      emit(VerifyEmailSuccess());
    } catch (error) {
      emit(const VerifyEmailFailure(error: 'Error Verifying your Email'));
    }
  }
}
