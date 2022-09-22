import 'package:clean_flutter/features/forget_password/bloc/reset_password_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../_shared/bloc/request_otp/request_otp_bloc.dart';
import '../../features/add_user/bloc/add_user_bloc.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/list_users/bloc/list_users_bloc.dart';
import '../../features/login/bloc/login_bloc.dart';
import '../../features/register/bloc/register_bloc.dart';
import '../../features/verify_email/bloc/verify_email_bloc.dart';
import '../../modules/auth/data/auth_repository_impl.dart';
import '../../modules/auth/domain/auth_repository.dart';
import '../../modules/user/data/user_repository.dart';
import '../../modules/user/domain/user_repository.dart';
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
  di.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(dio: di(), hive: di()));
  di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(dio: di(), hive: di()));

  //! Bloc Injection
  di.registerLazySingleton(() =>
      AuthBloc(authRepository: di(), userRepository: di())..add(AppLoaded()));
  di.registerFactory(() => LoginBloc(authRepository: di()));
  di.registerFactory(() => RegisterBloc(userRepository: di(), loginBloc: di()));
  di.registerFactory(() => AddUserBloc(userRepository: di()));
  di.registerFactory(
      () => ListUsersBloc(userRepository: di())..add(ListUsersFetched()));
  di.registerFactory(() => VerifyEmailBloc(authRepository: di()));
  di.registerFactory(() => RequestOtpBloc(authRepository: di()));
  di.registerFactory(() => ResetPasswordBloc(authRepository: di()));
}
