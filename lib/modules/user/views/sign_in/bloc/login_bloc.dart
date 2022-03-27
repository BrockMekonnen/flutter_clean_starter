import 'package:bloc/bloc.dart';
import 'package:clean_flutter/modules/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/ui/bloc/auth/auth_bloc.dart';
import '../../../../../_core/usecase.dart';
import '../../../domain/usecase/index.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;
  final SignInUseCase _signIn;
  final GetUserUseCase _getUser;
  LoginBloc({
    required AuthBloc authBloc,
    required SignInUseCase signIn,
    required GetUserUseCase getUser,
  })  : _authBloc = authBloc,
        _signIn = signIn,
        _getUser = getUser,
        super(LoginInitial()) {
    on<LoginInSubmitted>(_loginInSubmitted);
  }

  Future<void> _loginInSubmitted(
      LoginInSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final result = await _signIn(Params(
        phone: event.email,
        password: event.password,
      ));
      print("before token");
      var token = result.fold((l) => null, (token) => token);
      if (token != null) {
        print("--------passed token--------");
        print(token);
        final result = await _getUser(NoParams());
        var user = result.fold((l) => null, (user) => user);
        if (user != null) {
          print("----------passed user---------");
          print(user);
          _authBloc.add(UserLoggedIn(user: user));
          emit(LoginSuccess());
          emit(LoginInitial());
          return;
        } else {
          emit(LoginFailure(error: 'Error Getting your Data'));
        }
      } else {
        emit(LoginFailure(error: 'Error Logging In try again...'));
      }
    } catch (e) {
      emit(LoginFailure(error: 'An unknown error occurred'));
    }
  }
}
