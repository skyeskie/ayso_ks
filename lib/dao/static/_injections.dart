// ignore_for_file: non_constant_identifier_names
import 'package:flutter_modular/flutter_modular.dart';

import 'games.dart';
import 'settings.dart';
import 'teams.dart';
import 'week_cache.dart';

final Bind DI_STATIC_GAMES_DAO = Bind((i) => GamesStaticDAO());
final Bind DI_STATIC_SETTINGS_DAO = Bind((i) => SettingsStaticDAO());
final Bind DI_STATIC_TEAMS_DAO = Bind((i) => TeamsStaticDAO());
final Bind DI_STATIC_WEEK_CACHE = Bind((i) => WeekCacheStaticDAO());

final List<Bind> STATIC_DAO_INJECTIONS = [
  DI_STATIC_GAMES_DAO,
  DI_STATIC_SETTINGS_DAO,
  DI_STATIC_TEAMS_DAO,
  DI_STATIC_WEEK_CACHE,
];
