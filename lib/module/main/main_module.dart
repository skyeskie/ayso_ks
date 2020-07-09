import 'package:ayso_ks/module/region/region_info_tile.dart';
import 'package:ayso_ks/module/region/region_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app.dart';
import 'home_view.dart';

class AysoAppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', child: (ctx, args) => HomeView()),
        Router('/region', module: RegionModule()),
        Router('/DEBUG', child: (ctx, args) => RegionInfoTile()),
      ];

  @override
  Widget get bootstrap => AysoApp();
}
