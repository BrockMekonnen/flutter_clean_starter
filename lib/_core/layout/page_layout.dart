import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../app_router.dart';
import '../di.dart';
import 'adaptive_layout/adaptive_destination.dart';
import 'adaptive_layout/adaptive_layout.dart';
import 'adaptive_layout/app_bar_actions.dart';
import 'adaptive_layout/navigation_service.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.title,
    required this.navTab,
    required this.page,
    this.floatingActionButton,
    this.hideNavBarOnMobile,
  });

  final String title;
  final NavTab? navTab;
  final Widget page;
  final FloatingActionButton? floatingActionButton;
  final bool? hideNavBarOnMobile;

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);
    if (isMobile && (hideNavBarOnMobile ?? false)) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: page,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
    return AdaptiveLayout(
      drawerKey: GlobalKey(),
      navigationService: di<NavigationService>(),
      includeBaseDestinationsInMenu: false,
      appBar: AppBar(title: Text(title), actions: appBarActions(context)),
      selectedTab: navTab ?? DefaultNavTab.none,
      onDestinationSelected: (d) => di<AppRouter>().router.go(d.route!),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingActionButton,
      destinations: getNavRoutes(),
      body: page,
    );
  }
}
