import 'package:get_it/get_it.dart';

import '../../_core/ui/bloc/auth/auth_bloc.dart';
import 'data/data_sources/local_data_source.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repo/auth_repository.dart';
import 'domain/usecase/index.dart';
import 'views/profile/bloc/profile_bloc.dart';
import 'views/sign_in/bloc/login_bloc.dart';

void injectUsers(GetIt container) {
  //! Bloc Injection
  container.registerLazySingleton(() => AuthBloc(
        authStatus: container(),
        getUser: container(),
        signIn: container(),
        signOut: container(),
      )..add(AppLoaded()));
  container.registerFactory(() => LoginBloc(
        authBloc: container(),
        signIn: container(),
        getUser: container(),
      ));
  container.registerFactory(() => ProfileBloc(getUser: container()));

  //! Data Source Injection
  container.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: container()));
  container.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(hive: container()));
  container.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: container(),
      localDataSource: container(),
    ),
  );

  //! Use Case Injection
  container.registerLazySingleton(
      () => GetAuthStatusUseCase(repository: container()));
  container
      .registerLazySingleton(() => GetUserUseCase(repository: container()));
  container.registerLazySingleton(() => SignInUseCase(repository: container()));
  container
      .registerLazySingleton(() => SignOutUseCase(repository: container()));
}
