// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i7;

import '../../modules/user/views/profile/pages/profile_page.dart' as _i6;
import '../../modules/user/views/sign_in/page/sign_in.dart' as _i2;
import '../../modules/user/views/sign_up/pages/sign_up_page.dart' as _i3;
import '../ui/layout/layout_page.dart' as _i4;
import '../ui/pages/home/home_page.dart' as _i5;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    UnAuthRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    AuthRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    LoginRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    SignUpRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SignUpPage());
    },
    DashboardRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.DashboardPage());
    },
    HomeRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.HomePage());
    },
    ProfileRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ProfilePage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(UnAuthRouter.name, path: '/login', children: [
          _i1.RouteConfig(LoginRoute.name, path: '', parent: UnAuthRouter.name),
          _i1.RouteConfig(SignUpRoute.name,
              path: 'signUp', parent: UnAuthRouter.name),
          _i1.RouteConfig('/#redirect',
              path: '/',
              parent: UnAuthRouter.name,
              redirectTo: '/login',
              fullMatch: true)
        ]),
        _i1.RouteConfig(AuthRouter.name, path: '/', children: [
          _i1.RouteConfig(DashboardRoute.name,
              path: '',
              parent: AuthRouter.name,
              children: [
                _i1.RouteConfig(HomeRouter.name,
                    path: 'home', parent: DashboardRoute.name),
                _i1.RouteConfig(ProfileRouter.name,
                    path: 'profile', parent: DashboardRoute.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class UnAuthRouter extends _i1.PageRouteInfo<void> {
  const UnAuthRouter({List<_i1.PageRouteInfo>? children})
      : super(UnAuthRouter.name, path: '/login', initialChildren: children);

  static const String name = 'UnAuthRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class AuthRouter extends _i1.PageRouteInfo<void> {
  const AuthRouter({List<_i1.PageRouteInfo>? children})
      : super(AuthRouter.name, path: '/', initialChildren: children);

  static const String name = 'AuthRouter';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i1.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpRoute extends _i1.PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: 'signUp');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i4.DashboardPage]
class DashboardRoute extends _i1.PageRouteInfo<void> {
  const DashboardRoute({List<_i1.PageRouteInfo>? children})
      : super(DashboardRoute.name, path: '', initialChildren: children);

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i5.HomePage]
class HomeRouter extends _i1.PageRouteInfo<void> {
  const HomeRouter() : super(HomeRouter.name, path: 'home');

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i6.ProfilePage]
class ProfileRouter extends _i1.PageRouteInfo<void> {
  const ProfileRouter() : super(ProfileRouter.name, path: 'profile');

  static const String name = 'ProfileRouter';
}
