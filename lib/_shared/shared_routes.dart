import 'package:go_router/go_router.dart';

import '../_core/router/app_router.dart';
import 'features/home/view/page/home_page.dart';
import 'features/landing/landing_page_loader.dart';

List<GoRoute> sharedRoutes() {
  return [
    GoRoute(
      path: "/",
      redirect: (_, __) => "/landing",
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
  ];
}
