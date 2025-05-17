import 'dart:io';

import 'package:flutter/foundation.dart';
import "package:universal_html/html.dart" as html;

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> isConnected() async {
    try {
      if (kIsWeb) {
        if (html.window.navigator.onLine != null && html.window.navigator.onLine!) {
          return true;
        } else {
          return false;
        }
      } else {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
