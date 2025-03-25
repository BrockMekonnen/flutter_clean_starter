import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(RegisterInitial()) {
    on<RegistrationRequested>(_registrationRequested);
  }

  void _registrationRequested(
    RegistrationRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    try {
      await _authRepository.register(
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        email: event.email,
        password: event.password,
      );

      emit(RegisterSuccess());
    } catch (error) {
      emit(const RegisterFailure(error: 'Error Registering User'));
    }
  }
}
