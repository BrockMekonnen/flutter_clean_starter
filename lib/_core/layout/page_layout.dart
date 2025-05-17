import 'package:flutter/material.dart';

import '../constants.dart';
import '../di.dart';
import '../router/app_router.dart';
import '../router/nav_routes.dart';
import 'adaptive_layout/adaptive_layout.dart';
import 'adaptive_layout/app_bar_actions.dart';
import 'adaptive_layout/navigation_service.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.title,
    required this.pageTab,
    required this.page,
  });

  final String title;
  final NavTab? pageTab;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        drawerKey: Constants.layoutDrawerKey,
        navigationService: di<NavigationService>(),
        includeBaseDestinationsInMenu: false,
        appBar: AppBar(title: Text(title), actions: appBarActions(context)),
        body: page,
        selectedTab: pageTab ?? NavTab.none,
        destinations: getNavItems(context),
        onDestinationSelected: (destination) {
          di<AppRouter>().router.go(destination.route!);
        },
      ),
    );
  }
}
