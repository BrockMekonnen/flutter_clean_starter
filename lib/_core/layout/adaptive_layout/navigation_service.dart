import 'package:flutter/material.dart';

class NavigationService {
  final ValueNotifier<bool> isExpanded = ValueNotifier(true);

  void toggleDrawer() {
    isExpanded.value = !isExpanded.value;
  }
}
