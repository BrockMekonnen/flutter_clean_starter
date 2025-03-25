import 'package:go_router/go_router.dart';

import '../../_core/router/app_router.dart';
import 'features/login/view/page/login_page.dart';
import 'features/profile/view/profile_page.dart';
import 'features/register/view/page/register_page.dart';

List<GoRoute> authRoutes() {
  return [
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: "/register",
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const RegisterPage(),
      ),
    ),
    GoRoute(
      path: "/profile",
      pageBuilder: (context, state) => FadeTransitionPage(
        key: fadeTransitionKey,
        child: const ProfilePage(),
      ),
    ),
  ];
}
