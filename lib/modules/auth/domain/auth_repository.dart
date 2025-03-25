import 'auth_status.dart';
import 'user.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  void logOut();
  void dispose();

  Future<void> isAuthenticated();
  Future<void> login({required String email, required String password});
  Future<User?> getUser();
  Future<void> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  });
}
