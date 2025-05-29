import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Constants {
  static const String apiBaseUrl = "http://0.0.0.0:8080/api";

  static const String cachedTokenRef = 'CACHED_TOKEN';
  static const String tokenBoxName = 'CACHED_TOKEN_BOX';

  static const String cachedUserRef = 'CACHED_USER';
  static const String userBoxName = 'CACHED_USER_BOX';

  static const String themeBoxName = "ThemeBox";
  static const String themeModeRef = "Mode";

  static const List<Breakpoint> breakpoints = [
    Breakpoint(start: 0, end: 600, name: MOBILE),
    Breakpoint(start: 601, end: 1080, name: TABLET),
    Breakpoint(start: 1081, end: 1920, name: DESKTOP),
    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
  ];

  static const String langAssetPath = 'assets/translations';
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('zh'),
    Locale('es'),
  ];

  static const String mainRouesDiKey = "MainRoutes";
  static const String navTabsDiKey = "NavTabs";
}
