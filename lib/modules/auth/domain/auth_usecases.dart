import 'package:dartz/dartz.dart';

import '../../../_core/error/failures.dart';
import 'auth_repository.dart';
import 'user.dart';

class AuthUsecases {
  final AuthRepository _authRepository;

  AuthUsecases(this._authRepository);

  Future<Either<Failure, void>> isAuthenticated() {
    return _authRepository.isAuthenticated();
  }

  Stream<User> getUserStream() {
    return _authRepository.getUserStream();
  }

  Future<Either<Failure, void>> logout() {
    return _authRepository.logout();
  }

  void dispose() => _authRepository.dispose();
}
