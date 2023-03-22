import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '_core/di/di.dart';
import '_core/router/router.dart';
import '_core/theme.dart';
import 'features/auth/bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final go = AppRouter(authBloc: authBloc);
    return MaterialApp.router(
      title: 'Clean Flutter',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          defaultScale: true,
          minWidth: 360,
          defaultName: MOBILE,
          breakpoints: const [
            ResponsiveBreakpoint.resize(360),
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.resize(600, name: 'MOBILE_LARGE'),
            ResponsiveBreakpoint.resize(850, name: TABLET),
            ResponsiveBreakpoint.resize(1080, name: DESKTOP),
          ]),
      routeInformationParser: go.router.routeInformationParser,
      routerDelegate: go.router.routerDelegate,
      routeInformationProvider: go.router.routeInformationProvider,
    );
  }
}
