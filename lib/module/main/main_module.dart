import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../dao/mem/_injections.dart';
import '../../dao/static/_injections.dart';
import '../../service/backend_interface.dart';
import '../../service/backend_json_asset.dart';
import '../region/region_module.dart';
import '../schedules/schedules_module.dart';
import '../search/search_module.dart';
import 'app.dart';
import 'cancellations_view.dart';
import 'data_controller.dart';
import 'home_view.dart';
import 'init_view.dart';
import 'settings_view.dart';

class AysoAppModule extends MainModule {
  @override
  List<Bind> get binds => [
        DI_IN_MEM_GAMES_DAO,
        DI_IN_MEM_SETTINGS_DAO,
        DI_IN_MEM_TEAMS_DAO,
        DI_IN_MEM_WEEK_CACHE,
        DI_STATIC_SETTINGS_READONLY,
        Bind<DataController>((i) => DataController()),
        Bind<BackendInterface>((i) => BackendJsonAsset()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (ctx, args) => HomeView()),
        Router('/cancellations', child: (ctx, args) => CancellationsView()),
        Router(
          '/init',
          child: (ctx, args) => InitView(interruptedRoute: args.data),
        ),
        Router('/region', module: RegionModule()),
        Router('/search', module: SearchModule()),
        Router('/settings', child: (ctx, args) => SettingsView()),
        Router('/schedules', module: SchedulesModule()),
      ];

  @override
  Widget get bootstrap => AysoApp();
}
