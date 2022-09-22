import 'auth_status.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<void> isAuthenticated();
  Future<void> logIn({required String email, required String password});
  Future<void> requestOTP({required String email, required String otpFor});
  Future<void> verifyEmail({required String code, required String email});
  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
  });
  void logOut();
  void dispose();
}
