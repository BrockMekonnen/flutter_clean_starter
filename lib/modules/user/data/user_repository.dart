import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../domain/user.dart';
import '../domain/user_repository.dart';
import 'models/remote_user.dart';

class UserRepositoryImpl implements UserRepository {
  User? _user;

  final Dio dio;
  final HiveInterface hive;

  UserRepositoryImpl({required this.dio, required this.hive});

  @override
  Future<User?> getUser() async {
    try {
      String path = '/users/me';
      final response = await dio.get(path);
      // print('User: ${response}');
      _user = RemoteUser.fromJson(response.data['data']);
    } catch (error) {
      // ignore: avoid_print
      print('Error getting User: $error');
    }
    if (_user != null) return _user;
    return User.empty;
  }

  @override
  Future<void> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required bool isTermAndConditionAgreed,
  }) async {
    try {
      String path = '/users';
      await dio.post(path, data: {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
        'password': password,
        'isTermAndConditionAgreed': isTermAndConditionAgreed,
      });
    } catch (error) {
      throw Exception('error registering user');
    }
  }

  @override
  Future<List<User>> fetchUsers([int page = 1, int limit = 10]) async {
    String path = "/users?page=$page&limit=$limit";
    try {
      final response = await dio.get(path);
      final users = <User>[];
      response.data['data'].forEach((item) {
        // print(item);
        users.add(RemoteUser.fromJson(item));
      });
      return users;
    } catch (error) {
      // print(error);
      throw Exception('error fetching users');
    }
  }
}
