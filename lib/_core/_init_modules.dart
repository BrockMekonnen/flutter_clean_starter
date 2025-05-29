import 'package:clean_starter/_core/constants.dart';
import 'package:flutter/material.dart';

import '../_shared/shared_module.dart';
import '../modules/auth/auth_module.dart';
import '../modules/post/post_module.dart';
import 'di.dart';
import 'layout/adaptive_layout/adaptive_destination.dart';

class AppModules {
  /// Initializes modules before the Flutter app runs (before `runApp()`).
  static void initBeforeRunApp() {
    registerAuthModule();
    registerSharedModule();
    registerPostModule();
  }

  /// Initializes modules after the Flutter app has started (after `runApp()`), when BuildContext is available.
  static void initAfterRunApp(BuildContext context) {
    var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
    //* Reset Nav tabs to avoid duplication
    navTabs.clear();

    registerAuthModuleWithContext(context);
    registerSharedModuleWithContext(context);
    registerPostModuleWithContext(context);

    navTabs.sort();
  }
}
