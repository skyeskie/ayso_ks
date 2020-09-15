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

// ignore: avoid_classes_with_only_static_members
/// Class for running configurations for dependency injection
///
/// Select versions of the different DAO implementations here
class DIConfig {
  /// Instantiate the Games DAO
  static GamesDAO gamesDAO = GamesInMemoryDAO();

  /// Instantiate the Teams DAO
  static TeamsDAO teamsDAO = TeamsInMemoryDAO();

  /// Instantiate the Week Cache
  static WeekCacheDAO weekCache = WeekCacheInMemoryDAO();

  /// Instantiate the backend client
  static BackendInterface remoteData = BackendJsonAsset();

  /// Instantiate the Settings DAO
  static SettingsDAO settingsDAO = SettingsInMemoryDAO();

  /// Instantiate the Twitter client
  static twitterApi twitterDAO = twitterApi(
    consumerKey: EnvironmentConfigGen.TWITTER_API_KEY,
    consumerSecret: EnvironmentConfigGen.TWITTER_API_SECRET,
    token: EnvironmentConfigGen.TWITTER_ACCESS_TOKEN,
    tokenSecret: EnvironmentConfigGen.TWITTER_ACCESS_SECRET,
  );

  /// Provide data controller
  static DataController dataController = DataController();

  /// Function that sets up all dependency injection in the app
  ///
  /// This should be called once in the main app configuration and not repeated.
  static void setupDependencyInjection() {
    GetIt.instance
      ..registerSingleton<GamesDAO>(gamesDAO)
      ..registerSingleton<TeamsDAO>(teamsDAO)
      ..registerSingleton<WeekCacheDAO>(weekCache)
      ..registerSingleton<BackendInterface>(remoteData)
      ..registerSingleton<SettingsDAO>(settingsDAO)
      ..registerSingleton<DataController>(dataController)
      ..registerSingleton<twitterApi>(twitterDAO)
      ..registerFactoryAsync<SettingsDataType>(
        () => GetIt.I.get<SettingsDAO>().getSettingsReadonly(),
      );
  }
}
