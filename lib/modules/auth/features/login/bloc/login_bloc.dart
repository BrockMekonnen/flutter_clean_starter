import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/auth_usecases.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthUsecases authUsecases,
  })  : _authUsecases = authUsecases,
        super(LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthUsecases _authUsecases;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    var result = await _authUsecases.login(
      email: event.email,
      password: event.password,
    );
    emit(result.fold(
      (error) => LoginFailure(error: error.getMessage()),
      (_) => LoginSuccess(),
    ));
  }
}
