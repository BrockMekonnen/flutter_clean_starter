import 'package:flutter/widgets.dart';

/// Used to configure items or destinations in the various navigation
/// mechanism. For [BottomNavigationBar], see [BottomNavigationBarItem]. For
/// [NavigationRail], see [NavigationRailDestination]. For [Drawer], see
/// [ListTile].
class AdaptiveDestination {
  final String title;
  final IconData icon;
  final String? route;

  AdaptiveDestination({
    required this.title,
    required this.icon,
    this.route,
  });
}
