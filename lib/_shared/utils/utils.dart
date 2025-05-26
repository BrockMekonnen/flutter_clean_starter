import 'package:flutter/foundation.dart';
import "package:universal_html/html.dart" as html;

class GlobalUtils {
  static void setThemeModeForWeb(String mode) {
    if (kIsWeb) {
      final storage = html.window.localStorage;
      if (mode == 'Light') {
        storage.update(
          'theme',
          (value) => 'light',
          ifAbsent: () => 'light',
        );
      } else if (mode == 'Dark') {
        storage.update(
          'theme',
          (value) => 'dark',
          ifAbsent: () => 'dark',
        );
      }
    }
  }
}
