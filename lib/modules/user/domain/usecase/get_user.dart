import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/user.dart';
import '../repo/auth_repository.dart';

class GetUserUseCase implements UseCase<User, NoParams> {
  final AuthRepository repository;

  GetUserUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
