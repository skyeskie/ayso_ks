import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sailor/sailor.dart';
import 'package:sailor/src/models/arguments_wrapper.dart';

import '../dao/settings.dart';
import '../routes_config.dart';

/// Makes sure app is initialized before doing normal route generation
///
/// Note: Once Modular RouteGuard allows redirection, maybe switch to
/// that rather than wrapping around the whole routing process
Route generateRoute(RouteSettings settings) {
  final dao = GetIt.I.get<SettingsDAO>();

  if (dao.isAppConfigured()) {
    return Routing.sailor.generator()(settings);
  }

  final delayed = RouteSettings(
    name: '/init',
    arguments: ArgumentsWrapper(
      routeParams: {
        'interruptedRoute':
            SailorParam<RouteSettings>(name: 'interruptedRoute'),
      },
      params: {'interruptedRoute': settings},
    ),
  );

  return Routing.sailor.generator()(delayed);
}
