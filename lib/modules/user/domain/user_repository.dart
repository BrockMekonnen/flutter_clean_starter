import 'user.dart';

abstract class UserRepository {
  Future<User?> getUser();
  Future<List<User>> fetchUsers([int page, int limit]);

  Future<void> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required bool isTermAndConditionAgreed,
  });
}
