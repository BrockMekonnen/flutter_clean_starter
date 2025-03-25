import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../_shared/bloc/request_otp/request_otp_bloc.dart';
import '../modules/auth/bloc/auth_bloc.dart';
import '../modules/auth/data/auth_repository_impl.dart';
import '../modules/auth/domain/auth_repository.dart';
import '../modules/auth/features/login/bloc/login_bloc.dart';
import '../modules/auth/features/register/bloc/register_bloc.dart';
import '../modules/user/data/user_repository.dart';
import '../modules/user/domain/user_repository.dart';
import '../modules/user/features/add_user/bloc/add_user_bloc.dart';
import '../modules/user/features/list_users/bloc/list_users_bloc.dart';
import 'dio.dart';
import 'hive.dart';

final di = GetIt.instance;

Future<void> initDependencyInjection() async {
  //! Core
  await HiveConfig.init();
  final Dio dio = await DioConfig.init();
  final HiveInterface hive = Hive;
  di.registerLazySingleton(() => dio);
  di.registerLazySingleton(() => hive);

  //! injection of user module
  di.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(dio: di(), hive: di()));
  di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(dio: di(), hive: di()));

  //! Bloc Injection
  di.registerLazySingleton(
      () => AuthBloc(authRepository: di(), userRepository: di())..add(AppLoaded()));
  di.registerFactory(() => LoginBloc(authRepository: di()));
  di.registerFactory(() => RegisterBloc(userRepository: di(), loginBloc: di()));
  di.registerFactory(() => AddUserBloc(userRepository: di()));
  di.registerFactory(() => ListUsersBloc(userRepository: di())..add(ListUsersFetched()));
  di.registerFactory(() => RequestOtpBloc(authRepository: di()));
}
