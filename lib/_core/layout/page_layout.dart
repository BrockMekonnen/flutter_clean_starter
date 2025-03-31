import 'package:flutter/material.dart';

import '../di.dart';
import '../router/app_router.dart';
import '../router/nav_routes.dart';
import 'adaptive_layout/adaptive_layout.dart';
import 'adaptive_layout/navigation_service.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.page,
    required this.title,
    required this.pageTab,
  });

  final Widget page;
  final String title;
  final NavTab? pageTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        appBar: AppBar(
          title: Text(title),
        ),
        includeBaseDestinationsInMenu: false,
        body: page,
        selectedTab: pageTab ?? NavTab.none,
        destinations: navItems,
        onDestinationSelected: (destination) {
          di<AppRouter>().router.go(destination.route!);
        },
        navigationService: di<NavigationService>(),
      ),
    );
  }
}
