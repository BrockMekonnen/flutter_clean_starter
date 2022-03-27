import 'package:clean_flutter/modules/user/data/hive/user_model.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
  }
}
