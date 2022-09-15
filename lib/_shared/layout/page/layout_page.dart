import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:clean_flutter/_shared/layout/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../_core/router/nav_routes.dart';
import '../utils/nav_items.dart';
import '../widgets/drawer_header.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({
    Key? key,
    required this.page,
    required this.pageTitle,
    required this.selectedTab,
  }) : super(key: key);

  final NavigationTab selectedTab;
  final Widget page;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        appBar: MainAppBar(
          context: context,
          title: pageTitle,
        ),
        drawerHeader: const SideDrawerHeader(),
        includeBaseDestinationsInMenu: false,
        body: page,
        selectedIndex: selectedTab.index,
        destinations: navItems,
        onDestinationSelected: (index) {
          navRoutes(index, context);
        },
      ),
    );
  }
}
