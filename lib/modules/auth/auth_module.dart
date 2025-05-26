import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../_core/constants.dart';
import '../../_core/di.dart';
import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import 'auth_routes.dart';
import 'bloc/auth_bloc.dart';
import 'data/auth_repository_impl.dart';
import 'data/models/user_model.dart';
import 'domain/auth_repository.dart';
import 'domain/auth_usecases.dart';
import 'features/login/bloc/login_bloc.dart';
import 'features/register/bloc/register_bloc.dart';

Future<void> registerAuthModule() async {
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

  //* register routes and nav tabs
  di<List<RouteBase>>(instanceName: Constants.mainRouesDiKey).addAll(authRoutes());
}

void registerAuthModuleWithContext(BuildContext context) {
  //* Add all auth module navigation tabs
  var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
  navTabs.addAll(getAuthNavTabs(context));
}
