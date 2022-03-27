import 'package:hive/hive.dart';

import '../../../../_core/error/exceptions.dart';
import '../../../../_core/utils/constants.dart';
import '../hive/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> getCachedCurrentUser();

  Future<String> getCachedToken();

  Future<void> cacheToken(String token);

  Future<void> cacheUser(UserModel userToCache);

  Future<void> removeToken();

  Future<void> removeUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveInterface hive;

  AuthLocalDataSourceImpl({required this.hive});

  @override
  Future<void> cacheToken(String token) async {
    try {
      var tokenBox = await hive.openBox('token');
      tokenBox.put(cachedToken, token);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(UserModel userToCache) async {
    try {
      var userBox = await hive.openBox('user');
      userBox.put(cachedUser, userToCache);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<UserModel> getCachedCurrentUser() async {
    final userBox = await hive.openBox('user');
    final cachedData = userBox.get(cachedUser);
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getCachedToken() async {
    final tokenBox = await hive.openBox('token');
    final cachedData = tokenBox.get(cachedToken);
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> removeToken() async {
    var tokenBox = await hive.openBox('token');
    tokenBox.delete(cachedToken);
    return;
  }

  @override
  Future<void> removeUser() async {
    final userBox = await hive.openBox('user');
    userBox.delete(cachedUser);
    return;
  }
}
