import 'dart:ui';

import '_core/_init_modules.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';

import '_core/constants.dart';
import '_core/di.dart';
import '_core/app_router.dart';
import '_core/theme.dart';
import '_shared/blocs/theme_mode_cubit.dart';
import 'modules/auth/bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeModeCubit>(create: (context) => di()),
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
    return BlocBuilder<ThemeModeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ToastificationWrapper(
          child: GlobalLoaderOverlay(
            child: MaterialApp.router(
              title: 'Clean Starter',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              routerDelegate: di<AppRouter>().router.routerDelegate,
              routeInformationParser: di<AppRouter>().router.routeInformationParser,
              routeInformationProvider: di<AppRouter>().router.routeInformationProvider,
              localizationsDelegates: [
                ...context.localizationDelegates,
                FormBuilderLocalizations.delegate,
              ],
              builder: (context, child) {
                AppModules.initAfterRunApp(context);
                return ResponsiveBreakpoints.builder(
                    breakpoints: Constants.breakpoints, child: child!);
              },
              scrollBehavior: MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
