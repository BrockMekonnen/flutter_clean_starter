import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../_core/constants.dart';
import '../utils/utils.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  final HiveInterface _hive;
  ThemeModeCubit({required HiveInterface hive})
      : _hive = hive,
        super(ThemeMode.light);

  Future<LazyBox<dynamic>> getBox() async => _hive.openLazyBox(Constants.themeBoxName);

  void loadTheme(ThemeMode mode) async {
    emit(mode);
  }

  darkMode() async {
    emit(ThemeMode.dark);
    final themeBox = await getBox();
    themeBox.put(Constants.themeModeRef, 'Dark');
    GlobalUtils.setThemeModeForWeb('Dark');
  }

  lightMode() async {
    emit(ThemeMode.light);
    final themeBox = await getBox();
    themeBox.put(Constants.themeModeRef, 'Light');
    GlobalUtils.setThemeModeForWeb('Light');
  }

  systemMode() async {
    emit(ThemeMode.system);
    final themeBox = await getBox();
    themeBox.put(Constants.themeModeRef, 'System');
  }
}
