// ignore_for_file: non_constant_identifier_names
import 'package:flutter_modular/flutter_modular.dart';

import '../backend.dart';
import '../games.dart';
import '../settings.dart';
import '../teams.dart';
import '../week_cache.dart';
import 'data.dart';
import 'games.dart';
import 'settings.dart';
import 'teams.dart';
import 'week_cache.dart';

final Bind DI_STATIC_GAMES_DAO = Bind<GamesDAO>((i) => GamesStaticDAO());
final Bind DI_STATIC_TEAMS_DAO = Bind<TeamsDAO>((i) => TeamsStaticDAO());
final Bind DI_STATIC_SETTINGS_DAO =
    Bind<SettingsDAO>((i) => SettingsStaticDAO(), lazy: false);
final Bind DI_STATIC_WEEK_CACHE =
    Bind<WeekCacheDAO>((i) => WeekCacheStaticDAO());

final Bind DI_STATIC_SETTINGS_READONLY =
    Bind<SettingsDataType>((i) => settings, lazy: false);

final List<Bind> STATIC_DAO_INJECTIONS = [
  DI_STATIC_GAMES_DAO,
  DI_STATIC_SETTINGS_DAO,
  DI_STATIC_TEAMS_DAO,
  DI_STATIC_WEEK_CACHE,
  DI_STATIC_SETTINGS_READONLY,
];
