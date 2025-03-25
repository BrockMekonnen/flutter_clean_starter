import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout/page/layout_page.dart';
import '../../_shared/view/error/error_page.dart';
import '../../modules/user/features/add_user/view/page/add_user_page.dart';
import '../../modules/auth/bloc/auth_bloc.dart';
import '../../_shared/features/home/view/page/home_page.dart';
import '../../_shared/features/landing/views/page/landing_page.dart';
import '../../modules/user/features/list_users/view/page/users_page.dart';
import '../../modules/auth/features/login/view/page/login_page.dart';
import '../../modules/auth/features/register/view/page/register_page.dart';
import '../../modules/auth/domain/auth_status.dart';

const fadeTransitionKey = ValueKey<String>('Layout_Scaffold');
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const String rootRouteName = 'root';
const String landingRouteName = 'landing';
const String loginRouteName = 'login';
const String registerRouteName = 'register';
const String homeRouteName = 'home';
const String listUserRouteName = 'list-user';
const String addUserRouteName = 'add-user';
const String walletRouteName = 'wallet';
const String verifyEmailRouteName = 'verify-email';
const String forgetPasswordRouteName = 'forget-password';
const String resetPasswordRouteName = 'reset-password';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({
    required this.authBloc,
  });

  late final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (_, __) => '/landing',
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
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (_, GoRouterState state, child) {
          return LayoutPage(page: child);
        },
        routes: <RouteBase>[
          GoRoute(
            name: homeRouteName,
            path: '/home',
            pageBuilder: (context, state) => FadeTransitionPage(
              key: fadeTransitionKey,
              child: const HomePage(),
            ),
          ),
          GoRoute(
            name: listUserRouteName,
            path: '/users',
            pageBuilder: (context, state) => FadeTransitionPage(
              key: fadeTransitionKey,
              child: const ListUsers(),
            ),
          ),
          GoRoute(
            name: addUserRouteName,
            path: '/add-user',
            pageBuilder: (context, state) => FadeTransitionPage(
              key: fadeTransitionKey,
              child: const AddUser(),
            ),
          ),
        ],
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
    '/verify-email',
    '/forget-password',
    '/reset-password',
  ];

  String? _guard(BuildContext context, GoRouterState state) {
    // debugPrint('authBloc.state: ${authBloc.state}');

    final verifying = state.matchedLocation == '/verify-email';
    final isUnverified = authBloc.state.status == AuthStatus.unverified;
    final verifyLoc = state.namedLocation(verifyEmailRouteName);
    if (isUnverified) return verifying ? null : verifyLoc;

    final isUnauthenticated = authBloc.state.status == AuthStatus.unauthenticated;
    final unAuthRoute = unAuthScope.contains(state.matchedLocation);
    final loggingIn = state.matchedLocation == '/login';
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
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (c, animation, a2, child) => FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
        );
  static final _curveTween = CurveTween(curve: Curves.easeIn);
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
