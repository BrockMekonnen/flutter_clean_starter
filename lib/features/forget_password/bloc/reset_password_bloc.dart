import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../modules/auth/domain/auth_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(ResetPasswordInitial()) {
    on<ResetPasswordRequested>(_resetPasswordRequested);
  }

  void _resetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordLoading());

    try {
      await _authRepository.resetPassword(
        email: event.email,
        code: event.code,
        password: event.password,
      );
      emit(ResetPasswordSuccess());
    } catch (error) {
      emit(const ResetPasswordFailure(
        message: "Error Resetting Your Password",
      ));
    }
  }
}
