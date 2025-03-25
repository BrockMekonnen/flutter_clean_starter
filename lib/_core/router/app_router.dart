import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_shared/features/error/error_page.dart';
import '../../modules/auth/bloc/auth_bloc.dart';
import '../../modules/auth/domain/auth_status.dart';

const fadeTransitionKey = ValueKey<String>('Layout_Scaffold');
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  final AuthBloc authBloc;
  final List<RouteBase> routes;

  AppRouter({
    required this.authBloc,
    required this.routes,
  });

  late final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: "/landing",
    routes: routes,
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: const ErrorPage(),
    ),
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    debugLogDiagnostics: false,
    redirect: _guard,
  );

  final unAuthScope = [
    '/login',
    '/register',
    '/landing',
  ];

  String? _guard(BuildContext context, GoRouterState state) {
    // debugPrint('authBloc.state: ${authBloc.state}');

    final isUnauthenticated = authBloc.state.status == AuthStatus.unauthenticated;
    final unAuthRoute = unAuthScope.contains(state.matchedLocation);
    final loggingIn = state.matchedLocation == '/login';

    if (isUnauthenticated && !loggingIn) return unAuthRoute ? null : "/login";

    final loggedIn = authBloc.state.status == AuthStatus.authenticated;

    if (loggedIn && (loggingIn || unAuthRoute)) {
      return "/home";
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
