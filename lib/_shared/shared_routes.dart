import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../_core/app_router.dart';
import '../_core/layout/adaptive_layout/adaptive_destination.dart';
import 'features/error/error_401_page.dart';
import 'features/home/page/home_page.dart';
import 'features/landing/page/landing_page_loader.dart';
import 'features/settings/page/settings_page.dart';
import 'features/splash/page/splash_page.dart';

enum SharedNavTab implements NavTab { none, home, settings }

List<AdaptiveDestination> getSharedNavTabs(BuildContext context) {
  return <AdaptiveDestination>[
    AdaptiveDestination(
      title: context.tr('layoutPage.home'),
      icon: Icons.home,
      route: '/home',
      navTab: SharedNavTab.home,
      order: 1,
    ),
    AdaptiveDestination(
      title: context.tr('layoutPage.settings'),
      icon: Icons.settings,
      route: '/settings',
      navTab: SharedNavTab.settings,
      order: 40,
    ),
  ];
}

List<GoRoute> sharedRoutes() {
  return [
    GoRoute(
      path: "/",
      redirect: (_, __) => "/splash",
    ),
    GoRoute(
      path: '/splash',
      redirect: initialRedirect,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: "/errors/401",
      pageBuilder: (context, state) => FadeTransitionPage(
        child: const Error401Page(),
      ),
    ),
    GoRoute(
      path: "/landing",
      redirect: unAuthRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: const LandingPageLoader(), // 👈 Lazy-load the page
      ),
    ),
    GoRoute(
      path: "/home",
      redirect: authRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: "/settings",
      redirect: authRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: const SettingsPage(),
      ),
    ),
  ];
}
