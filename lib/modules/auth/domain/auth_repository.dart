import 'auth_status.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<void> isAuthenticated();
  Future<void> logIn({
    required String email,
    required String password,
  });
  void logOut();
  void dispose();
}
