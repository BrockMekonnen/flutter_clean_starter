import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../domain/user.dart';
import 'models/json/remote_user.dart';

class UserRepository {
  User? _user;

  final Dio dio;
  final HiveInterface hive;

  UserRepository({required this.dio, required this.hive});

  Future<User?> getUser() async {
    try {
      String path = '/users/me';
      final response = await dio.get(path);
      _user = RemoteUser.fromJson(response.data);
    } catch (error) {
      print('Error getting User: $error');
    }
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User.empty,
    );
  }
}
