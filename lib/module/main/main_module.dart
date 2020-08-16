import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import 'cancellations_view.dart';
import 'home_view.dart';
import 'init_view.dart';
import 'settings_view.dart';

/// Navigation/Routing configuration for the main module
final List<SailorRoute> mainModuleRoutes = <SailorRoute>[
  SailorRoute(
    name: '/',
    builder: (ctx, args, params) => HomeView(),
  ),
  SailorRoute(
    name: '/cancellations',
    builder: (ctx, args, params) => CancellationsView(),
  ),
  SailorRoute(
    name: '/init',
    params: [
      SailorParam<RouteSettings>(name: 'interruptedRoute'),
    ],
    builder: (ctx, args, params) {
      return InitView(interruptedRoute: params.param('interruptedRoute'));
    },
  ),
  SailorRoute(
    name: '/settings',
    builder: (ctx, args, params) => SettingsView(),
  ),
];
