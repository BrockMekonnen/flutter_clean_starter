import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../_shared/widgets/language_change_button.dart';
import '../../../_shared/widgets/theme_mode_button.dart';
import '../../../modules/auth/bloc/auth_bloc.dart';

List<Widget> appBarActions(BuildContext context) {
  return [
    ThemeModeButton(radius: 30),
    const SizedBox(width: 5),
    LanguageChangeButton(),
    const SizedBox(width: 5),
    BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          String route = kIsWeb ? "/landing" : "/login";
          context.go(route);
        }
      },
      child: IconButton(
        tooltip: context.tr('layoutPage.logout'),
        onPressed: () {
          context.read<AuthBloc>().add(AuthLogoutRequested());
        },
        icon: Icon(Icons.logout_rounded),
      ),
    ),
    const SizedBox(width: 15),
  ];
}
