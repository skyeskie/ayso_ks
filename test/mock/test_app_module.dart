import 'package:ayso_ks/dao/static/_injections.dart';
import 'package:ayso_ks/module/main/main_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_modular/src/inject/bind.dart';
import 'package:flutter_modular/src/interfaces/child_module.dart';

class TestAppModuleHelper extends IModularTest {
  @override
  List<Bind> get binds => [
        DI_STATIC_GAMES_DAO,
        DI_STATIC_SETTINGS_DAO,
        DI_STATIC_TEAMS_DAO,
        DI_STATIC_WEEK_CACHE,
      ];

  @override
  IModularTest get modulardependency => null;

  @override
  ChildModule get module => AysoAppModule();
}
