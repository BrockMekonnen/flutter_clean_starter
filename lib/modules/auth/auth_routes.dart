import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import '../../_core/app_router.dart';
import 'features/login/page/login_page.dart';
import 'features/profile/page/profile_page.dart';
import 'features/register/page/register_page.dart';

enum AuthNavTab implements NavTab { profile }

List<AdaptiveDestination> getAuthNavTabs(BuildContext context) {
  return <AdaptiveDestination>[
    AdaptiveDestination(
      title: context.tr('layoutPage.profile'),
      icon: Icons.person,
      route: '/profile',
      navTab: AuthNavTab.profile,
      order: 3,
    ),
  ];
}

List<GoRoute> authRoutes() {
  return [
    GoRoute(
      path: "/login",
      redirect: unAuthRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: "/register",
      redirect: unAuthRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const RegisterPage(),
      ),
    ),
    GoRoute(
      path: "/profile",
      redirect: authRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const ProfilePage(),
      ),
    ),
  ];
}
