import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/login/bloc/login_bloc.dart';
import '../../modules/auth/data/auth_repository.dart';
import '../../modules/user/data/user_repository.dart';
import '../dio.dart';
import '../hive.dart';

final di = GetIt.instance;

Future<void> initDependencyInjection() async {
  //! Core
  await HiveConfig.init();
  final Dio dio = await DioConfig.init();
  final HiveInterface hive = Hive;
  di.registerLazySingleton(() => dio);
  di.registerLazySingleton(() => hive);

  //! injection of user module
  di.registerLazySingleton(() => UserRepository(dio: di(), hive: di()));
  di.registerLazySingleton(() => AuthRepository(dio: di(), hive: di()));

  //! Bloc Injection
  di.registerLazySingleton(() =>
      AuthBloc(authRepository: di(), userRepository: di())..add(AppLoaded()));
  di.registerFactory(() => LoginBloc(authRepository: di()));
}
