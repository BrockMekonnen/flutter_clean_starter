import 'package:flutter/widgets.dart';

import '../../router/nav_routes.dart';

/// Used to configure items or destinations in the various navigation
/// mechanism. For [BottomNavigationBar], see [BottomNavigationBarItem]. For
/// [NavigationRail], see [NavigationRailDestination]. For [Drawer], see
/// [ListTile].
class AdaptiveDestination {
  final String title;
  final IconData icon;
  final String? route;
  final NavTab? navTab;

  AdaptiveDestination({
    required this.title,
    required this.icon,
    this.route,
    this.navTab,
  });
}
