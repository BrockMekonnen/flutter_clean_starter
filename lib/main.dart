import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '_core/_bootstrap.dart';
import '_core/constants.dart';
import 'app.dart';
import 'generated/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Bootstrap.init();
  runApp(EasyLocalization(
    path: Constants.langAssetPath,
    supportedLocales: Constants.supportedLocales,
    assetLoader: const CodegenLoader(),
    fallbackLocale: Locale('en', 'US'),
    child: App(),
  ));
}
