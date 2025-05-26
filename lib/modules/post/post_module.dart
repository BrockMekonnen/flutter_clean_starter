import 'post_routes.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

Future<void> registerPostModule(GetIt di, List<RouteBase> router) async {
  //* inject repositories

  //* inject Usecases

  //* inject blocs

  //* register routes
  router.addAll(postRoutes());
}
