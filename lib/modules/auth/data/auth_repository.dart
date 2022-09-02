import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../_core/config.dart';
import '../domain/auth_status.dart';

class AuthRepository {
  final _controller = StreamController<AuthStatus>();

  final Dio dio;
  final HiveInterface hive;

  AuthRepository({required this.dio, required this.hive});

  Stream<AuthStatus> get status async* {
    yield* _controller.stream;
  }

  Future<void> isAuthenticated() async {
    try {
      final tokenBox = await hive.openLazyBox('tokenBox');
      final token = await tokenBox.get(cachedToken);
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

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      String path = '/users/login';
      final response = await dio.post(path, data: {
        "email": email,
        "password": password,
      });
      // print('response: $response');
      final tokenBox = await hive.openLazyBox('tokenBox');
      await tokenBox.put(cachedToken, response.data['token']);
      return _controller.add(AuthStatus.authenticated);
    } catch (error) {
      // print('Error: $error');
      throw Error();
    }
  }

  void logOut() async {
    _controller.add(AuthStatus.unauthenticated);
    final tokenBox = await hive.openLazyBox('tokenBox');
    tokenBox.clear();
  }

  void dispose() => _controller.close();
}
