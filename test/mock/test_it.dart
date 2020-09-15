import 'package:ayso_ks/dao/games.dart';
import 'package:ayso_ks/dao/mem/settings.dart';
import 'package:ayso_ks/dao/settings.dart';
import 'package:ayso_ks/dao/static/games.dart';
import 'package:ayso_ks/dao/static/settings.dart';
import 'package:ayso_ks/dao/static/teams.dart';
import 'package:ayso_ks/dao/static/week_cache.dart';
import 'package:ayso_ks/dao/teams.dart';
import 'package:ayso_ks/dao/week_cache.dart';
import 'package:ayso_ks/routes_config.dart';
import 'package:ayso_ks/service/backend_interface.dart';
import 'package:ayso_ks/service/backend_static.dart';
import 'package:ayso_ks/service/twitter_mock.dart';
import 'package:get_it/get_it.dart';

import 'sailor_mock.dart';

// ignore: avoid_classes_with_only_static_members
class TestIt {
  //Reference main GetIt
  static GetIt I = GetIt.instance;
  static GetIt instance = GetIt.I;

  //Default registrations
  static void registerGamesDAO() =>
      I.registerSingleton<GamesDAO>(GamesStaticDAO());

  static void registerTeamsDAO() =>
      I.registerSingleton<TeamsDAO>(TeamsStaticDAO());

  static void registerWeekCache() =>
      I.registerSingleton<WeekCacheDAO>(WeekCacheStaticDAO());

  static void registerSettings() =>
      I.registerSingleton<SettingsDAO>(SettingsStaticDAO());

  static void registerSettingsMutable({
    int regionNumber,
    List<String> savedTeams = const [],
  }) {
    if (!I.isRegistered<TeamsDAO>()) {
      registerTeamsDAO();
    }
    if (I.isRegistered<SettingsDAO>()) {
      I.unregister<SettingsDAO>();
    }
    I.registerSingleton<SettingsDAO>(SettingsInMemoryDAO(
      initData: SettingsDataType(
        regionNumber: regionNumber,
        savedTeams: savedTeams,
      ),
    ));
  }

  static void registerBackend() =>
      I.registerSingleton<BackendInterface>(BackendStatic());

  //Compound
  static void registerAllStatic() {
    registerGamesDAO();
    registerTeamsDAO();
    registerWeekCache();
    registerSettings();
    registerBackend();
  }

  static SailorFake fakeNav;

  static SailorFake stubNavigation() {
    fakeNav = SailorFake();
    Routing.sailor = fakeNav;
    Routing.createRoutes();
    return fakeNav;
  }

  static void clean() {
    fakeNav?.clear();
    I.reset();
  }

  static void registerTwitter() => MockTwitterApi.register();
}
