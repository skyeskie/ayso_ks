import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../dao/settings.dart';

/// Makes sure app is initialized before doing normal route generation
///
/// Note: Once Modular RouteGuard allows redirection, maybe switch to
/// that rather than wrapping around the whole routing process
Route generateRoute(RouteSettings settings) {
  final dao = Modular.get<SettingsDAO>();

  if (dao.isAppConfigured()) {
    return Modular.generateRoute(settings);
  }

  final delayed = RouteSettings(
    name: '/init',
    arguments: settings,
  );

  return Modular.generateRoute(delayed);
}
