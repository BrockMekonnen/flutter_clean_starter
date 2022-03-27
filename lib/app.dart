import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '_core/di/get_It.dart';
import '_core/router/router.gr.dart';
import '_core/ui/bloc/auth/auth_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(create: (context) => container()),
    ], child: AppView());
  }
}

class AppView extends StatelessWidget {
  AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: ((context, state) {
        return MaterialApp.router(
          title: "Clean Flutter",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              minWidth: 350,
              maxWidth: 2460,
              defaultScale: true,
              breakpoints: const [
                ResponsiveBreakpoint.autoScale(360),
                ResponsiveBreakpoint.autoScale(400, name: 'SMALL_MOBILE'),
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.resize(850, name: TABLET),
                ResponsiveBreakpoint.resize(1080, name: DESKTOP),
              ]),
          routerDelegate:
              AutoRouterDelegate.declarative(_appRouter, routes: (_) {
            return [
              if (state is Authenticated)
                const AuthRouter()
              else
                const UnAuthRouter()
            ];
          }),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      }),
    );
  }
}
