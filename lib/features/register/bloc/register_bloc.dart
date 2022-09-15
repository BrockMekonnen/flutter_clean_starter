import 'package:bloc/bloc.dart';
import 'package:clean_flutter/features/login/login.dart';
import 'package:equatable/equatable.dart';

import '../../../modules/user/domain/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  final LoginBloc _loginBloc;

  RegisterBloc({
    required UserRepository userRepository,
    required LoginBloc loginBloc,
  })  : _userRepository = userRepository,
        _loginBloc = loginBloc,
        super(RegisterInitial()) {
    on<RegistrationRequested>(_registrationRequested);
  }

  void _registrationRequested(
    RegistrationRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    try {
      await _userRepository.register(
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        email: event.email,
        password: event.password,
        isTermAndConditionAgreed: event.isTermAndConditionAgreed,
      );
      _loginBloc
          .add(LoginSubmitted(email: event.email, password: event.password));
      emit(RegisterSuccess());
    } catch (error) {
      emit(const RegisterFailure(error: 'Error Registering User'));
    }
  }
}
