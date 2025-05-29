import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/theme_mode_cubit.dart';

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({
    super.key,
    this.radius,
  });

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: context.tr('layoutPage.changeTheme'),
      constraints: BoxConstraints(minWidth: radius ?? 44, minHeight: radius ?? 44),
      onPressed: () {
        if (Theme.of(context).brightness == Brightness.dark) {
          BlocProvider.of<ThemeModeCubit>(context).lightMode();
        } else {
          BlocProvider.of<ThemeModeCubit>(context).darkMode();
        }
      },
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined,
        // size: 26,
      ),
    );
  }
}
