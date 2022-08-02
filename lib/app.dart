import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '_core/router/router.dart';
import '_core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final go = AppRouter();
    return MaterialApp.router(
      title: 'Clean Flutter',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
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
