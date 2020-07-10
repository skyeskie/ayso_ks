import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../dao/static/_injections.dart';
import '../region/region_info_tile.dart';
import '../region/region_module.dart';
import '../schedules/schedules_module.dart';
import '../search/search_module.dart';
import 'app.dart';
import 'cancellations_view.dart';
import 'home_view.dart';
import 'init_config_view.dart';
import 'settings_view.dart';

class AysoAppModule extends MainModule {
  @override
  List<Bind> get binds => [...STATIC_DAO_INJECTIONS];

  @override
  List<Router> get routers => [
        Router('/', child: (ctx, args) => HomeView()),
        Router('/cancellations', child: (ctx, args) => CancellationsView()),
        Router('/init', child: (ctx, args) => InitConfigView()),
        Router('/region', module: RegionModule()),
        Router('/search', module: SearchModule()),
        Router('/settings', child: (ctx, args) => SettingsView()),
        Router('/schedules', module: SchedulesModule()),
        Router('/DEBUG', child: (ctx, args) => RegionInfoTile()),
      ];

  @override
  Widget get bootstrap => AysoApp();
}
