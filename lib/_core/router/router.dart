import 'package:auto_route/auto_route.dart';
import 'package:clean_flutter/_core/ui/pages/home/home_page.dart';
import 'package:clean_flutter/modules/user/views/profile/pages/profile_page.dart';

import '../../modules/user/views/sign_in/page/sign_in.dart';
import '../../modules/user/views/sign_up/pages/sign_up_page.dart';
import '../ui/layout/layout_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      name: 'UnAuthRouter',
      page: EmptyRouterPage,
      path: '/login',
      children: [
        AutoRoute(
          path: '',
          page: LoginPage,
        ),
        AutoRoute(
          path: 'signUp',
          page: SignUpPage,
        ),
        RedirectRoute(path: '/', redirectTo: '/login'),
      ],
    ),
    AutoRoute(
      initial: true,
      name: 'AuthRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          name: "DashboardRoute",
          path: "",
          page: DashboardPage,
          children: [
            AutoRoute(
              path: "home",
              name: "HomeRouter",
              page: HomePage,
            ),
            AutoRoute(
              path: 'profile',
              name: 'ProfileRouter',
              page: ProfilePage,
            ),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
