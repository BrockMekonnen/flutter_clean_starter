import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import "package:universal_html/html.dart" as html;
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

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

  static EventTransformer<E> throttleDroppable<E>({Duration? duration}) {
    return (events, mapper) {
      return droppable<E>()
          .call(events.throttle(duration ?? Duration(milliseconds: 100)), mapper);
    };
  }
}
