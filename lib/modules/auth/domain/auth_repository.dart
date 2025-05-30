import 'package:dartz/dartz.dart';

import '../../../_core/error/failures.dart';
import 'user.dart';

abstract class AuthRepository {
  Stream<User> getUserStream();
  void dispose();

  Future<Either<Failure, void>> isAuthenticated();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> login({required String email, required String password});
  Future<Either<Failure, User?>> getMe();

  Future<Either<Failure, void>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required bool iAgree,
  });
}
