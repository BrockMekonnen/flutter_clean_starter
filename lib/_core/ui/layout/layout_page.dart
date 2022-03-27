import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../router/router.gr.dart';
import 'navigation/navigation.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRouter(),
        ProfileRouter()
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return AdaptiveNavigation(
            drawerHeader: Card(
              margin: EdgeInsets.zero,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FlutterLogo(size: 42.0),
                    SizedBox(
                      width: 30,
                    ),
                    Text("Clean Flutter"),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
            includeBaseDestinationsInMenu: true,
            appBar: MainAppBar(context: context),
            body: FadeTransition(
              opacity: animation,
              child: child,
            ),
            selectedIndex: tabsRouter.activeIndex,
            destinations: navItems,
            onDestinationSelected: (index) {
              tabsRouter.setActiveIndex(index);
            });
      },
    );
  }
}
