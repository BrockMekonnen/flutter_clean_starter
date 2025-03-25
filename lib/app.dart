import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '_core/constants.dart';
import '_core/di.dart';
import '_core/router/app_router.dart';
import '_core/theme.dart';
import 'modules/auth/bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>(create: (context) => di())],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Clean Starter',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [FormBuilderLocalizations.delegate],
      builder: (context, child) => ResponsiveBreakpoints.builder(
          breakpoints: Constants.breakpoints, child: child!),
      routeInformationParser: di<AppRouter>().router.routeInformationParser,
      routerDelegate: di<AppRouter>().router.routerDelegate,
      routeInformationProvider: di<AppRouter>().router.routeInformationProvider,
    );
  }
}
