import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/auth_usecases.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthUsecases _authUsecases;

  RegisterBloc({required AuthUsecases authUsecases})
      : _authUsecases = authUsecases,
        super(RegisterInitial()) {
    on<RegistrationRequested>(_registrationRequested);
  }

  void _registrationRequested(
    RegistrationRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    var result = await _authUsecases.register(
      firstName: event.firstName,
      lastName: event.lastName,
      phone: event.phone,
      email: event.email,
      password: event.password,
      iAgree: event.iAgree,
    );
    emit(result.fold(
      (error) => RegisterFailure(error: error.getMessage()),
      (_) => RegisterSuccess(),
    ));
  }
}
