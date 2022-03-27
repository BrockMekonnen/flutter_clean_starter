import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '_core/di/get_It.dart' as di;

import 'app.dart';

void main() {
  di.init();
  BlocOverrides.runZoned(() => runApp(App()));
}
