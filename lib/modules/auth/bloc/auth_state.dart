part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final User user;

  const AuthState._({this.status = AuthStatus.unknown, this.user = User.empty});

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unverified(User user)
      : this._(status: AuthStatus.unverified, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
