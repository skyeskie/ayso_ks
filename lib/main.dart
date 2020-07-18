import 'package:flutter/material.dart';

import 'di_config.dart';
import 'module/main/app.dart';
import 'routes_config.dart';

void main() {
  setupDependencyInjection();
  Routing.createRoutes();
  runApp(AysoApp());
}
