import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  /// Authenticates a user using his [username] and [password]
  Future<Either<Failure, String>> authenticate(
      {required String phone, required String password});

  /// Returns whether the [User] is authenticated.
  Future<Either<Failure, bool>> isAuthenticated();

  /// Returns the current authenticated [User].
  Future<Either<Failure, User>> getCurrentUser();

  /// Logs out the [User]
  Future<Either<Failure, void>> signOut();
}
