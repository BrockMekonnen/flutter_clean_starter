import 'dart:async';

import 'package:clean_flutter/modules/user/domain/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../domain/user.dart';
import 'models/json/remote_user.dart';

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
      _user = RemoteUser.fromJson(response.data);
    } catch (error) {
      // ignore: avoid_print
      print('Error getting User: $error');
    }
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User.empty,
    );
  }

  @override
  Future<void> register(
      {required String firstName,
      required String lastName,
      required String phone,
      required String email,
      required String password,
      required bool isTermAndConditionAgreed}) async {
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
      // ignore: avoid_print
      // print('Register Error: $error');
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
        users.add(User(
          id: item['id'],
          firstName: item['firstName'],
          lastName: item['lastName'],
          phone: item['phone'],
          email: item['email'],
          roles: const [],
        ));
      });
      return users;
    } catch (error) {
      // print(error);
      throw Exception('error fetching users');
    }
  }
}
