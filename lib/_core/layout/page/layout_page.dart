import 'package:flutter/material.dart';

import '../../router/nav_routes.dart';
import '../adaptive_layout/adaptive_layout.dart';
import '../widgets/drawer_header.dart';
import '../widgets/main_app_bar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({
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
        drawerHeader: const SideDrawerHeader(),
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
