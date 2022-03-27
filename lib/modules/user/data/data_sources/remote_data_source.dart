import 'package:dio/dio.dart';

import '../hive/user_model.dart';
import '../mappers/user_mapper.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> getCurrentUser();

  Future<String> authenticate(String phone, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> authenticate(String phone, String password) async {
    String path = "/users/login";
    final data = {'phone': phone, 'password': password, 'type': 'user'};
    final response = await dio.post(path, data: data);
    return TokenMapper.fromJson(response.data);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    String path = '/users/me';
    final response = await dio.get(path);
    return UserMapper.fromJosn(response.data);
  }
}
