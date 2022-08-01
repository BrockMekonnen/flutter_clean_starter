import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'dio_config.dart';
import 'hive_config.dart';

final container = GetIt.instance;

Future<void> init() async {
  //! Core
  await HiveConfig.init();
  final Dio dio = await DioConfig.init();
  final HiveInterface hive = Hive;
  container.registerLazySingleton(() => dio);
  container.registerLazySingleton(() => hive);

  //! injection of user module
}
