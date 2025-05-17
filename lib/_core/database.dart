import 'package:hive_flutter/hive_flutter.dart';

import 'di.dart';

class Database {
  static init() async {
    await Hive.initFlutter();
    di.registerLazySingleton<HiveInterface>(() => Hive);
  }
}
