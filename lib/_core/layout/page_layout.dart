import 'package:flutter/material.dart';

import '../constants.dart';
import '../di.dart';
import '../app_router.dart';
import 'adaptive_layout/adaptive_destination.dart';
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
        selectedTab: pageTab ?? DefaultNavTab.none,
        onDestinationSelected: (d) => di<AppRouter>().router.go(d.route!),
        destinations: getNavRoutes(),
        body: page,
      ),
    );
  }
}
