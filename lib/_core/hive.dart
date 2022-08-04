import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static init() async {
    await Hive.initFlutter();
  }
}
