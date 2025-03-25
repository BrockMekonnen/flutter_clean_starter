import 'package:flutter/material.dart';

import '../router/nav_routes.dart';
import 'adaptive_layout/adaptive_layout.dart';

import 'adaptive_layout/main_app_bar.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.page,
    // required this.pageTitle,
    // required this.selectedTab,
  });

  final Widget page;
  // final NavigationTab selectedTab;
  // final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        appBar: MainAppBar(
          context: context,
          // title: pageTitle,
        ),
        includeBaseDestinationsInMenu: false,
        body: page,
        selectedIndex: 0,
        destinations: navItems,
        onDestinationSelected: (destination) {
          // navRoutes(index, context);
        },
      ),
    );
  }
}
