import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'constants.dart';
import 'di.dart';
import 'error/exceptions.dart';

class HttpClient {
  static Future<void> init() async {
    Dio dio = Dio(BaseOptions(baseUrl: Constants.apiBaseUrl));

    // add interceptor to dio
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // get user token
          final tokenBox = await Hive.openLazyBox(Constants.tokenBoxName);
          final token = await tokenBox.get(Constants.cachedTokenRef);
          if (token != Null) {
            options.headers['authorization'] = "Bearer $token";
          }
          debugPrint("request: ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // debugPrint('request success');
          if (response.statusCode! >= 200 || response.statusCode! < 300) {
            return handler.next(response);
          } else {
            response = ServerException() as Response;
            return handler.next(response);
          }
        },
        onError: (DioException e, handler) {
          // ignore: avoid_print
          print('onError: => $e');
          return handler.next(e);
        },
      ),
    );

    di.registerLazySingleton(() => dio);
  }
}
