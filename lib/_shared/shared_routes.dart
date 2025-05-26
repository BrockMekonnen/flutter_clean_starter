import 'package:go_router/go_router.dart';

import '../_core/router/app_router.dart';
import 'features/home/page/home_page.dart';
import 'features/landing/page/landing_page_loader.dart';
import 'features/settings/page/settings_page.dart';
import 'features/splash/page/splash_page.dart';

List<GoRoute> sharedRoutes() {
  return [
    GoRoute(
      path: "/",
      redirect: (_, __) => "/splash",
    ),
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: "/landing",
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const LandingPageLoader(), // 👈 Lazy-load the page
      ),
    ),
    GoRoute(
      path: "/home",
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: "/settings",
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const SettingsPage(),
      ),
    ),
  ];
}
