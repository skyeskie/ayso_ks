import 'package:get_it/get_it.dart';
import 'package:twitter_api/twitter_api.dart';

import 'dao/games.dart';
import 'dao/mem/games.dart';
import 'dao/mem/settings.dart';
import 'dao/mem/teams.dart';
import 'dao/mem/week_cache.dart';
import 'dao/settings.dart';
import 'dao/teams.dart';
import 'dao/week_cache.dart';
import 'environment_config_gen.dart';
import 'module/main/data_controller.dart';
import 'service/backend_interface.dart';
import 'service/backend_json_asset.dart';

/// Function that sets up all dependency injection in the app
///
/// This should be called once in the main app configuration and not repeated.
/// Select versions of the different DAO implementations here
void setupDependencyInjection() {
  GetIt.instance
    ..registerSingleton<GamesDAO>(GamesInMemoryDAO())
    ..registerSingleton<TeamsDAO>(TeamsInMemoryDAO())
    ..registerSingleton<WeekCacheDAO>(WeekCacheInMemoryDAO())
    ..registerSingleton<BackendInterface>(BackendJsonAsset())
    ..registerSingleton<SettingsDAO>(
      SettingsInMemoryDAO(),
      //dependsOn: [TeamsDAO],
    )
    ..registerSingleton<DataController>(
      DataController(),
//dependsOn: [BackendInterface, GamesDAO, SettingsDAO, TeamsDAO, WeekCacheDAO]
    )
    ..registerFactoryAsync<SettingsDataType>(
      () => GetIt.I.get<SettingsDAO>().getSettingsReadonly(),
    )
    ..registerSingleton<twitterApi>(twitterApi(
      consumerKey: EnvironmentConfigGen.TWITTER_API_KEY,
      consumerSecret: EnvironmentConfigGen.TWITTER_API_SECRET,
      token: EnvironmentConfigGen.TWITTER_ACCESS_TOKEN,
      tokenSecret: EnvironmentConfigGen.TWITTER_ACCESS_SECRET,
    ));
}
