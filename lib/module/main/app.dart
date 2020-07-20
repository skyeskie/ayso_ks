import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import '../../routes_config.dart';
import '../../util/ready_route_guard.dart';

class AysoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AYSO Kansas',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: Routing.sailor.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: '/',
      navigatorObservers: [
        SailorLoggingObserver(),
      ],
    );
  }
}
