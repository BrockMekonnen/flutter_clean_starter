import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../_core/constants.dart';
import '../_core/di.dart';
import '../_core/layout/adaptive_layout/adaptive_destination.dart';
import '../_core/layout/adaptive_layout/navigation_service.dart';
import 'bloc/theme_mode_cubit.dart';
import 'shared_routes.dart';

Future<void> registerSharedModule() async {
  //* inject data sources */

  //* inject repositories

  //* inject blocs
  di.registerSingleton<ThemeModeCubit>(ThemeModeCubit(hive: di())..loadTheme(di()));
  di.registerSingleton<NavigationService>(NavigationService());

  //* register routes and navigation tabs
  di<List<RouteBase>>(instanceName: Constants.mainRouesDiKey).addAll(sharedRoutes());
}

void registerSharedModuleWithContext(BuildContext context) {
  //* Add all shared module navigation tabs
  var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
  navTabs.addAll(getSharedNavTabs(context));
}
