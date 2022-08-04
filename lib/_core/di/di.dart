import 'package:auth_repository/auth_repository.dart';
import 'package:clean_flutter/modules/auth/bloc/auth_bloc.dart';
import 'package:clean_flutter/modules/login/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:user_repository/user_repository.dart';

final di = GetIt.instance;

Future<void> initDependencyInjection() async {
  //! Core
  // await HiveConfig.init();
  // final Dio dio = await DioConfig.init();
  // final HiveInterface hive = Hive;
  // di.registerLazySingleton(() => dio);
  // di.registerLazySingleton(() => hive);

  //! injection of user module
  di.registerLazySingleton(() => UserRepository());
  di.registerLazySingleton(() => AuthRepository());

  //! Bloc Injection
  di.registerLazySingleton(
      () => AuthBloc(authRepository: di(), userRepository: di()));
  di.registerFactory(() => LoginBloc(authRepository: di()));
}
