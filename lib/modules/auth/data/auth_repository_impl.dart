import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

import '../../../_core/constants.dart';
import '../../../_core/error/exceptions.dart';
import '../../../_core/error/failures.dart';
import '../../../_core/network_info.dart';
import '../domain/auth_repository.dart';
import '../domain/user.dart';
import 'models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _userController = BehaviorSubject<User>();

  final Dio dio;
  final HiveInterface hive;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.dio,
    required this.hive,
    required this.networkInfo,
  });

  @override
  Stream<User> getUserStream() => _userController.asBroadcastStream();

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await clearCache();
      _userController.add(User.empty);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure("Oops, Something went wrong while clearing cached data!"));
    }
  }

  @override
  void dispose() => _userController.close();

  @override
  Future<Either<Failure, void>> isAuthenticated() async {
    try {
      if (_userController.hasValue) {
        return Right(null);
      } else {
        final user = await _getCachedUser();
        _userController.add(user);
      }
      return Right(null);
    } catch (error) {
      _userController.add(User.empty);
      return Left(CacheFailure('Error occurred while loading cached data!'));
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      String path = '/users/login';
      final tokenRes = await dio.post(path, data: {"email": email, "password": password});
      String? token = tokenRes.data?['data']['token'];
      if (token == null) {
        return Left(ServerFailure("Error occurred while authenticating user!"));
      }
      await _cacheToken(token);

      final user = await _getMe();
      await _cacheUser(user);

      _userController.add(user);
      return Right(null);
    } catch (error) {
      if (error is DioException) {
        final message = DioExceptions.fromDioError(error).toString();
        return Left(ServerFailure(message));
      } else if (error is CacheException) {
        return Left(CacheFailure("Oops, Something went wrong while caching user data!"));
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required bool iAgree,
  }) async {
    try {
      String path = '/users';
      await dio.post(path, data: {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
        'password': password,
        'isTermAndConditionAgreed': iAgree,
      });
      return Right(null);
    } catch (error) {
      if (error is DioException) {
        final message = DioExceptions.fromDioError(error).toString();
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> getMe() async {
    try {
      var user = await _getMe();
      _userController.add(user);
      return Right(user);
    } catch (error) {
      if (error is DioException) {
        final message = DioExceptions.fromDioError(error).toString();
        return Left(ServerFailure(message));
      }
      return Left(ServerFailure());
    }
  }

  Future<UserModel> _getMe() async {
    String path = '/users/me';
    final response = await dio.get(path);
    var user = UserModel.fromJson(response.data['data']);
    return user;
  }

  Future<void> _cacheToken(String token) async {
    try {
      final tokenBox = await hive.openLazyBox(Constants.tokenBoxName);
      await tokenBox.put(Constants.cachedTokenRef, token);
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> _cacheUser(UserModel user) async {
    try {
      final userBox = await hive.openLazyBox(Constants.userBoxName);
      userBox.put(Constants.cachedUserRef, user);
    } catch (e) {
      throw CacheException();
    }
  }

  Future<UserModel> _getCachedUser() async {
    final userBox = await hive.openLazyBox(Constants.userBoxName);
    final user = await userBox.get(Constants.cachedUserRef);
    if (user != null) {
      return user;
    } else {
      throw CacheException();
    }
  }

  Future<void> clearCache() async {
    final userBox = await hive.openLazyBox(Constants.userBoxName);
    final tokenBox = await hive.openLazyBox(Constants.tokenBoxName);
    await tokenBox.clear();
    await userBox.clear();
  }
}
