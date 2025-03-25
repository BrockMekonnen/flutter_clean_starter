// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// import '../_shared/bloc/theme_mode/theme_mode_cubit.dart';
// import '../_shared/domain/onboard.dart';
// import 'container.dart';

// class LoadInitialData {
//   static Future<void> init() async {
//     final hive = di<HiveInterface>();
//     final themeBox = await hive.openLazyBox(themeBoxName);
//     final onboardBox = await hive.openLazyBox('OnboardBox');
//     final mode = await themeBox.get(themeModeRef);
//     final status = await onboardBox.get('status');
//     di.registerLazySingleton<ThemeMode>(() => _selectTheme(mode));
//     di.registerLazySingleton<Onboard>(() => Onboard(_selectStatus(status)));
//   }

//   static ThemeMode _selectTheme(dynamic mode) {
//     switch (mode) {
//       case 'Light':
//         return ThemeMode.light;
//       case 'Dark':
//         return ThemeMode.dark;
//       default:
//         return ThemeMode.system;
//     }
//   }

//   static OnboardStatus _selectStatus(dynamic status) {
//     if (status == 'seen') return OnboardStatus.seen;
//     return OnboardStatus.unseen;
//   }
// }
