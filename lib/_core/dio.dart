import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'config.dart';
import 'error/exceptions.dart';

class DioConfig {
  static Future<Dio> init() async {
    Dio dio = Dio(BaseOptions(baseUrl: apiBaseUrl));

    // add interceptor to dio
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // get user token
          final tokenBox = await Hive.openLazyBox('tokenBox');
          final token = await tokenBox.get(cachedToken);
          if (token != Null) {
            options.headers['authorization'] = "Bearer $token";
          }
          debugPrint("request url: ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('request success');
          if (response.statusCode! >= 200 || response.statusCode! < 300) {
            return handler.next(response);
          } else {
            response = ServerException() as Response;
            return handler.next(response);
          }
        },
        onError: (DioError e, handler) {
          // ignore: avoid_print
          print('onError: => $e');
          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
