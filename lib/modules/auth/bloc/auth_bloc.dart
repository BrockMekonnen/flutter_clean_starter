import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/auth_usecase.dart';
import '../domain/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase _userUsecase;

  AuthBloc({required AuthUsecase userUsecase})
      : _userUsecase = userUsecase,
        super(const AuthState()) {
    on<AppLoaded>(_appLoaded);
    on<AuthStatusSubscriptionRequested>(_onAuthSubscriptionRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  @override
  Future<void> close() {
    _userUsecase.dispose();
    return super.close();
  }

  Future<void> _appLoaded(AppLoaded event, Emitter<AuthState> emit) async {
    await _userUsecase.isAuthenticated();
  }

  Future<void> _onAuthSubscriptionRequested(
    AuthStatusSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _userUsecase.isAuthenticated();
    await emit.forEach<User>(
      _userUsecase.getUserStream(),
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
    _userUsecase.logout();
  }
}
