import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';

import '../../../_core/router/nav_routes.dart';
import '../utils/nav_items.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({
    Key? key,
    required this.page,
    required this.selectedTab,
  }) : super(key: key);

  final NavigationTab selectedTab;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
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
