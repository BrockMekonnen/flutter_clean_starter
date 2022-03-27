import 'package:bloc/bloc.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../modules/user/domain/entities/user.dart';
import '../../../../modules/user/domain/usecase/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthStatusUseCase _authStatus;
  final GetUserUseCase _getUser;
  final SignInUseCase _signIn;
  final SignOutUseCase _signOut;
  AuthBloc(
      {required GetAuthStatusUseCase authStatus,
      required GetUserUseCase getUser,
      required SignInUseCase signIn,
      required SignOutUseCase signOut})
      : _authStatus = authStatus,
        _getUser = getUser,
        _signIn = signIn,
        _signOut = signOut,
        super(AuthInitial()) {
    on<AppLoaded>(_appLoaded);
    on<UserLoggedIn>(_userLoggedIn);
    on<UserLoggedOut>(_userLoggedOut);
  }
  Future<void> _appLoaded(AppLoaded event, Emitter<AuthState> emit) async {
    emit(Loading());
    // emit(const AuthFailure(message: 'Error Getting User Data'));
    try {
      final result = await _authStatus(NoParams());
      var isAuth = result.fold((l) => false, (isAuth) => isAuth);
      if (isAuth) {
        var result = await _getUser(NoParams());
        var user = result.fold((l) => null, (user) => user);
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(const AuthFailure(message: 'Error Getting User Data'));
        }
      } else {
        // emit(const AuthFailure(message: 'Error Getting user Token'));
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(const AuthFailure(message: 'error occurred'));
    }
  }

  void _userLoggedIn(UserLoggedIn event, Emitter<AuthState> emit) {
    emit(Loading());
    emit(Authenticated(user: event.user));
  }

  void _userLoggedOut(UserLoggedOut event, Emitter<AuthState> emit) async {
    emit(Loading());
    await _signOut(NoParams());
    emit(Unauthenticated());
  }
}
