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

  Future<Either<Failure, void>> login({required String email, required String password}) {
    return _authRepository.login(email: email, password: password);
  }

  Future<Either<Failure, User?>> getMe() {
    return _authRepository.getMe();
  }

  Future<Either<Failure, void>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required bool iAgree,
  }) {
    return _authRepository.register(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        password: password,
        iAgree: iAgree);
  }
}
