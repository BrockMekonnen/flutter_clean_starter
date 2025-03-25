import 'package:flutter/material.dart';

import '_core/di.dart';
import 'app.dart';

Future<void> main() async {
  await initDependencyInjection();
  runApp(const App());
}
