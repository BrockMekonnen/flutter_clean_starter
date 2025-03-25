import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '_core/di.dart';
import '_core/router/router.dart';
import '_core/theme.dart';
import 'modules/auth/bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

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
  const AppView({super.key});

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
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: breakpoints,
        child: child!,
      ),
      routeInformationParser: go.router.routeInformationParser,
      routerDelegate: go.router.routerDelegate,
      routeInformationProvider: go.router.routeInformationProvider,
    );
  }
}

List<Breakpoint> breakpoints = [
  Breakpoint(start: 0, end: 600, name: MOBILE),
  Breakpoint(start: 601, end: 1080, name: TABLET),
  Breakpoint(start: 1081, end: 1920, name: DESKTOP),
  Breakpoint(start: 1921, end: double.infinity, name: '4K'),
];
