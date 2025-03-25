import 'package:clean_flutter/_core/di.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Database {
  static init() async {
    await Hive.initFlutter();
    di.registerLazySingleton<HiveInterface>(() => Hive);
  }
}
