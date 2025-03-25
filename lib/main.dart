import 'package:flutter/material.dart';

import '_core/bootstrap.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Bootstrap.init();
  runApp(const App());
}
