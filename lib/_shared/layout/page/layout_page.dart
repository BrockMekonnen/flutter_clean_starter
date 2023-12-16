import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../_core/router/nav_routes.dart';
import '../utils/nav_items.dart';
import '../widgets/drawer_header.dart';
import '../widgets/main_app_bar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({
    Key? key,
    required this.page,
    // required this.pageTitle,
    // required this.selectedTab,
  }) : super(key: key);

  final Widget page;
  // final NavigationTab selectedTab;
  // final String pageTitle;

  @override
  Widget build(BuildContext context) {
    if (GoRouter.of(context).location.contains('details') &&
        ResponsiveWrapper.of(context).isMobile) {
      debugPrint('it contains details page');
      return Scaffold(
        body: page,
      );
    }
    return Scaffold(
      body: AdaptiveLayout(
        appBar: MainAppBar(
          context: context,
          // title: pageTitle,
        ),
        drawerHeader: const SideDrawerHeader(),
        includeBaseDestinationsInMenu: false,
        body: page,
        selectedIndex: calculateSelectedIndex(context),
        destinations: navItems,
        onDestinationSelected: (index) {
          navRoutes(index, context);
        },
      ),
    );
  }
}
