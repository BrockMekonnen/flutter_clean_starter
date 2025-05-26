import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../_core/app_router.dart';

class CustomToast {
  static void showSuccessNotification({
    required String title,
    required String description,
  }) {
    toastification.show(
      overlayState: rootNavigatorKey.currentState?.overlay,
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      icon: Icon(Icons.check_circle_outline_rounded),
      title: Text(title),
      description: Text(description),
      alignment: kIsWeb ? Alignment.topRight : Alignment.topCenter,
      borderRadius: BorderRadius.circular(12.0),
    );
  }

  static void showErrorNotification({
    required String title,
    required String description,
  }) {
    toastification.show(
      overlayState: rootNavigatorKey.currentState?.overlay,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.error,
      icon: Icon(Icons.cancel_outlined),
      title: Text(title),
      description: Text(description),
      alignment: kIsWeb ? Alignment.topRight : Alignment.topCenter,
      borderRadius: BorderRadius.circular(12.0),
    );
  }
}
