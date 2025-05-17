import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../_shared/widgets/language_change_button.dart';
import '../../../_shared/widgets/theme_mode_button.dart';
import '../../../modules/auth/bloc/auth_bloc.dart';

List<Widget> appBarActions(BuildContext context) {
  return [
    ThemeModeButton(radius: 30),
    const SizedBox(width: 5),
    LanguageChangeButton(),
    const SizedBox(width: 5),
    IconButton(
      tooltip: context.tr('layoutPage.logout'),
      onPressed: () {
        context.read<AuthBloc>().add(AuthLogoutRequested());
      },
      icon: Icon(Icons.logout_rounded),
    ),
    const SizedBox(width: 15),
  ];
}
