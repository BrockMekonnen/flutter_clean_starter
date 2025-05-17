import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/auth_repository.dart';
import '../domain/auth_status.dart';
import '../domain/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState()) {
    on<AppLoaded>(_appLoaded);
    on<AuthStatusSubscriptionRequested>(_onAuthSubscriptionRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  @override
  Future<void> close() {
    _authRepository.dispose();
    return super.close();
  }

  Future<void> _appLoaded(AppLoaded event, Emitter<AuthState> emit) async {
    await _authRepository.isAuthenticated();
  }

  Future<void> _onAuthSubscriptionRequested(
    AuthStatusSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.isAuthenticated();
    await emit.forEach<User>(
      _authRepository.getUserStream(),
      onData: (user) {
        // print("auth_bloc: $user");
        if (user == User.empty) {
          return state.copyWith(
            status: AuthStatus.unauthenticated,
            user: user,
          );
        } else {
          // if (!user.isEmailVerified) {
          //   return state.copyWith(
          //     status: AuthStatus.unverified,
          //     user: user,
          //   );
          // }

          return state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
          );
        }
      },
      onError: (_, __) {
        return state.copyWith(
          status: AuthStatus.unauthenticated,
        );
      },
    );
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.logout();
  }
}
