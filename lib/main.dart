import 'package:flutter/material.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependency();
  runApp(const MyApp());
}

Future<void> initializeDependency() async {
}