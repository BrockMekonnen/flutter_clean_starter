import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_shared/layout/layout_page.dart';
import '../../_shared/views/error/error_page.dart';
import '../../modules/auth/bloc/auth_bloc.dart';
import '../../modules/home/home.dart';
import '../../modules/landing/views/page/landing_page.dart';
import '../../modules/login/view/page/login_page.dart';
import '../../modules/register/register.dart';

const fadeTransitionKey = ValueKey<String>('Layout_Scaffold');
const layoutKey = ValueKey<String>('Layout_Key');

const String rootRouteName = 'root';
const String landingRouteName = 'landing';
const String loginRouteName = 'login';
const String registerRouteName = 'register';
const String homeRouteName = 'home';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final router = GoRouter(
    routes: [
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (_) => '/landing',
      ),
      GoRoute(
        name: landingRouteName,
        path: '/landing',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: fadeTransitionKey,
          child: const LandingPage(),
        ),
      ),
      GoRoute(
        name: loginRouteName,
        path: '/login',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: fadeTransitionKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: registerRouteName,
        path: '/register',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: fadeTransitionKey,
          child: const RegisterPage(),
        ),
      ),
      GoRoute(
        name: homeRouteName,
        path: '/home',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: fadeTransitionKey,
          child: const LayoutPage(page: HomePage()),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: const ErrorPage(),
    ),
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    debugLogDiagnostics: true,
    redirect: _guard,
  );

  final unAuthScope = [
    '/login',
    '/register',
    '/landing',
  ];

  String? _guard(GoRouterState state) {
    debugPrint('authBloc.state: ${authBloc.state}');

    final isUnauthenticated =
        authBloc.state.status == AuthStatus.unauthenticated;
    final unAuthRoute = unAuthScope.contains(state.subloc);
    final loggingIn = state.subloc == '/login';
    final loginLoc = state.namedLocation(loginRouteName);
    if (isUnauthenticated && !loggingIn) return unAuthRoute ? null : loginLoc;

    final loggedIn = authBloc.state.status == AuthStatus.authenticated;
    final homeLoc = state.namedLocation(homeRouteName);
    if (loggedIn && (loggingIn || unAuthRoute)) {
      return homeLoc;
    }

    return null;
  }
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          transitionsBuilder: (c, animation, a2, child) => FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
          child: child,
        );
  static final _curveTween = CurveTween(curve: Curves.easeIn);
}
