import 'package:clean_flutter/_shared/shared_routes.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

Future<void> registerSharedModule(GetIt di, List<RouteBase> router) async {
  //*? inject data sources */

  //? inject repositories

  //? inject blocs

  //? register routes
  router.addAll(sharedRoutes());
}
