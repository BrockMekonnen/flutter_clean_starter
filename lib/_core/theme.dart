import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = FlexThemeData.light(
  // Playground built-in scheme made with FlexSchemeColor.from() API.
  colors: FlexSchemeColor.from(
    primary: const Color(0xFF1145A4),
    secondary: const Color(0xFFB61D1D),
    brightness: Brightness.light,
    swapOnMaterial3: true,
  ),
  // Component theme configurations for light mode.
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    useM2StyleDividerInM3: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
  ),
  // Direct ThemeData properties.
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
);

final ThemeData darkTheme = FlexThemeData.dark(
  // Playground built-in scheme made with FlexSchemeColor.from() API
  // The input FlexSchemeColor is identical to light mode, but uses
  // default Error and toDark() methods to convert it to a dark theme.
  colors: FlexSchemeColor.from(
    primary: const Color(0xFF1145A4),
    secondary: const Color(0xFFB61D1D),
    brightness: Brightness.light,
    swapOnMaterial3: true,
  ).defaultError.toDark(30, true),
  // Component theme configurations for dark mode.
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    blendOnColors: true,
    useM2StyleDividerInM3: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
  ),
  // Direct ThemeData properties.
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
);
