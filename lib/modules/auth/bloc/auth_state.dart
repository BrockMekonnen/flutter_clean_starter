part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, unverified }

class AuthState extends Equatable {
  final AuthStatus status;
  final User user;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user = User.empty,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
  }) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
      );

  @override
  List<Object> get props => [status, user];
}
