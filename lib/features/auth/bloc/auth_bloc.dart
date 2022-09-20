import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../modules/auth/domain/auth_repository.dart';
import '../../../modules/auth/domain/auth_status.dart';
import '../../../modules/user/domain/user.dart';
import '../../../modules/user/domain/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late StreamSubscription<AuthStatus> _authStatusSubscription;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AppLoaded>(_appLoaded);
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    _authStatusSubscription = _authRepository.status
        .listen((status) => add(AuthStatusChanged(status)));
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    _authRepository.dispose();
    return super.close();
  }

  Future<void> _appLoaded(AppLoaded event, Emitter<AuthState> emit) async {
    await _authRepository.isAuthenticated();
  }

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    // print('event.status: ${event.status}');
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        final user = await _tryGetUser();
        return emit(user != null
            ? user.isEmailVerified
                ? AuthState.authenticated(user)
                : AuthState.unverified(user)
            : const AuthState.unauthenticated());
      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
      default:
        return emit(const AuthState.unknown());

    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
