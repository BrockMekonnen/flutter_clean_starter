import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../_core/layout/adaptive_layout/navigation_service.dart';
import 'bloc/theme_mode_cubit.dart';
import 'shared_routes.dart';

Future<void> registerSharedModule(GetIt di, List<RouteBase> router) async {
  //*? inject data sources */

  //? inject repositories

  //? inject blocs
  di.registerSingleton<ThemeModeCubit>(ThemeModeCubit(hive: di())..loadTheme(di()));
  di.registerSingleton<NavigationService>(NavigationService());

  //? register routes
  router.addAll(sharedRoutes());
}
