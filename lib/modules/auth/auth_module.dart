import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'auth_routes.dart';
import 'bloc/auth_bloc.dart';
import 'data/auth_repository_impl.dart';
import 'domain/auth_repository.dart';
import 'features/login/bloc/login_bloc.dart';
import 'features/register/bloc/register_bloc.dart';

Future<void> registerAuthModule(GetIt di, List<RouteBase> router) async {
  //*? inject data sources */

  //? inject repositories
  di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(dio: di(), hive: di()));

  //? inject blocs
  di.registerLazySingleton(() => AuthBloc(authRepository: di())..add(AppLoaded()));
  di.registerFactory(() => LoginBloc(authRepository: di()));
  di.registerFactory(() => RegisterBloc(authRepository: di()));

  //? register routes
  router.addAll(authRoutes());
}
