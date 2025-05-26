import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'auth_routes.dart';
import 'bloc/auth_bloc.dart';
import 'data/auth_repository_impl.dart';
import 'data/models/user_model.dart';
import 'domain/auth_repository.dart';
import 'domain/auth_usecases.dart';
import 'features/login/bloc/login_bloc.dart';
import 'features/register/bloc/register_bloc.dart';

Future<void> registerAuthModule(GetIt di, List<RouteBase> router) async {
  //* register Hive Adapters
  di<HiveInterface>().registerAdapter<UserModel>(UserModelAdapter());

  //* inject repositories
  di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(dio: di(), hive: di(), networkInfo: di()));

  //* Inject Usecases
  di.registerLazySingleton<AuthUsecases>(() => AuthUsecases(di()));

  //* inject blocs
  di.registerLazySingleton(
      () => AuthBloc(userUsecase: di())..add(AuthStatusSubscriptionRequested()));
  di.registerFactory(() => LoginBloc(authRepository: di()));
  di.registerFactory(() => RegisterBloc(authRepository: di()));

  //* register routes
  router.addAll(authRoutes());
}
