import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.bahamaBlue,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 3,
  appBarOpacity: 0.9,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData().copyWith(
    blendOnColors: true,
    defaultRadius: 6.0,
    inputDecoratorRadius: 4,
  ),
);

final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.bahamaBlue,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 3,
  appBarOpacity: 0.9,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData().copyWith(
    blendOnColors: true,
    defaultRadius: 6.0,
    inputDecoratorRadius: 4,
  ),
);
