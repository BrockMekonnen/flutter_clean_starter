import 'package:flutter/widgets.dart';

/// A marker interface for navigation tabs used to represent logical navigation
/// targets in the app.
///
/// This abstraction allows multiple enum types or classes to be treated
/// uniformly when used in navigation-related components like [AdaptiveDestination].
///
/// For example, separate enums like `MainNavTab` and `PostNavTab` can both
/// implement [NavTab] to support a flexible and extensible navigation system.
abstract class NavTab {
  const NavTab();
}

/// A default fallback [NavTab] indicating that a page doesn't belong to
/// any specific navigation group.
///
/// This can be used for standalone routes or pages that are not represented
/// in the primary navigation structure.
enum DefaultNavTab implements NavTab { none }

/// Used to configure items or destinations in the various navigation
/// mechanisms like BottomNavigationBar, NavigationRail, or Drawer.
class AdaptiveDestination implements Comparable<AdaptiveDestination> {
  final String title;
  final IconData icon;
  final int order;
  final String? route;
  final NavTab? navTab;

  AdaptiveDestination({
    required this.title,
    required this.icon,
    required this.order,
    this.route,
    this.navTab,
  });

  @override
  int compareTo(AdaptiveDestination other) {
    return order.compareTo(other.order);
  }
}
