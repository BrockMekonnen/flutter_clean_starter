import 'package:clean_starter/_core/app_router.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoadingOverlay {
  static void show() {
    if (rootNavigatorKey.currentContext != null) {
      rootNavigatorKey.currentContext!.loaderOverlay.show(widgetBuilder: (p) {
        return LoaderOverlayLoadingIndicator();
      });
    }
  }

  static void hide() {
    if (rootNavigatorKey.currentContext != null) {
      rootNavigatorKey.currentContext!.loaderOverlay.hide();
    }
  }
}

class LoaderOverlayLoadingIndicator extends StatelessWidget {
  const LoaderOverlayLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
