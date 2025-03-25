import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../_core/constants.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_status.dart';
import '../domain/user.dart';
import 'models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _controller = StreamController<AuthStatus>();
  User? _user;

  final Dio dio;
  final HiveInterface hive;

  AuthRepositoryImpl({required this.dio, required this.hive});

  @override
  Stream<AuthStatus> get status async* {
    yield* _controller.stream;
  }

  @override
  void logOut() async {
    _controller.add(AuthStatus.unauthenticated);
    final tokenBox = await hive.openLazyBox(Constants.cachedToken);
    tokenBox.clear();
  }

  @override
  void dispose() => _controller.close();

  @override
  Future<void> isAuthenticated() async {
    try {
      final tokenBox = await hive.openLazyBox(Constants.tokenBoxName);
      final token = await tokenBox.get(Constants.cachedToken);
      if (token != null && token.isNotEmpty) {
        _controller.add(AuthStatus.authenticated);
      } else {
        _controller.add(AuthStatus.unauthenticated);
      }
    } catch (error) {
      // print("error: $error");
      _controller.add(AuthStatus.unknown);
    }
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      String path = '/users/login';
      final response = await dio.post(path, data: {
        "email": email,
        "password": password,
      });
      final tokenBox = await hive.openLazyBox('tokenBox');
      await tokenBox.put(Constants.cachedToken, response.data['token']);
      return _controller.add(AuthStatus.authenticated);
    } catch (error) {
      throw Error();
    }
  }

  @override
  Future<void> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      String path = '/users';
      await dio.post(path, data: {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
        'password': password,
      });
    } catch (error) {
      throw Exception('error registering user');
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      String path = '/users/me';
      final response = await dio.get(path);
      // print('User: ${response}');
      _user = UserModel.fromJson(response.data['data']);
    } catch (error) {
      // ignore: avoid_print
      print('Error getting User: $error');
    }
    if (_user != null) return _user;
    return User.empty;
  }
}
