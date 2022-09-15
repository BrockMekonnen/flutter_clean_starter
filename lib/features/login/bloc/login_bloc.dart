import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../modules/auth/domain/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await _authRepository.logIn(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } catch (_) {
      emit(LoginFailure(error: 'Error Logging In'));
    }
  }
}
