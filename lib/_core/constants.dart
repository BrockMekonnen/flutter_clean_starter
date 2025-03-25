import 'package:responsive_framework/responsive_framework.dart';

class Constants {
  static const String cachedToken = 'CACHED_TOKEN';
  static const String tokenBoxName = 'CACHED_TOKEN_BOX';

  static const String cachedUser = 'CACHED_USER';
  static const String userBoxName = 'CACHED_USER_BOX';

  static const String apiBaseUrl = "http://localhost:3000/api";

  static const List<Breakpoint> breakpoints = [
    Breakpoint(start: 0, end: 600, name: MOBILE),
    Breakpoint(start: 601, end: 1080, name: TABLET),
    Breakpoint(start: 1081, end: 1920, name: DESKTOP),
    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
  ];
}
