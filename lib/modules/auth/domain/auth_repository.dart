import 'auth_status.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<void> isAuthenticated();
  Future<void> logIn({
    required String email,
    required String password,
  });
  Future<void> requestOTP({required String email});
  Future<void> verifyEmail({
    required String code,
    required String email,
  });
  void logOut();
  void dispose();
}
