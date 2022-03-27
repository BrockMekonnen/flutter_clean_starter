import 'package:dartz/dartz.dart';

import '../../../../_core/error/exceptions.dart';
import '../../../../_core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repo/auth_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../mappers/user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> authenticate({
    required String phone,
    required String password,
  }) async {
    try {
      print("got here!");
      final token = await remoteDataSource.authenticate(phone, password);
      localDataSource.cacheToken(token);
      return Right(token);
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final remoteUser = await remoteDataSource.getCurrentUser();
      localDataSource.cacheUser(remoteUser);
      return Right(UserMapper.toEntity(remoteUser));
    } catch (err) {
      try {
        final localUser = await localDataSource.getCachedCurrentUser();
        return Right(UserMapper.toEntity(localUser));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await localDataSource.getCachedToken();
      if (token.isNotEmpty) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await localDataSource.removeToken();
      await localDataSource.removeUser();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
