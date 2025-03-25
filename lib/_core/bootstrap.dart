import 'database.dart';
import 'http_client.dart';

import 'di.dart';
import 'router/app_router.dart';
import '../_shared/shared_module.dart';
import '../modules/auth/auth_module.dart';
import 'package:go_router/go_router.dart';

class Bootstrap {
  static Future<void> init() async {
    //* Initiate Core
    final List<RouteBase> routes = [];
    await HttpClient.init();
    await Database.init();

    //* Registering Modules
    await registerAuthModule(di, routes);
    await registerSharedModule(di, routes);

    //* initialize all routes
    di.registerLazySingleton(() => AppRouter(authBloc: di(), routes: routes));
  }
}
