// ignore_for_file: non_constant_identifier_names
import 'package:flutter_modular/flutter_modular.dart';

import '../games.dart';
import '../settings.dart';
import '../teams.dart';
import '../week_cache.dart';
import 'games.dart';
import 'settings.dart';
import 'teams.dart';
import 'week_cache.dart';

final Bind DI_IN_MEM_GAMES_DAO = Bind<GamesDAO>((i) => GamesInMemoryDAO());
final Bind DI_IN_MEM_TEAMS_DAO = Bind<TeamsDAO>((i) => TeamsInMemoryDAO());
final Bind DI_IN_MEM_SETTINGS_DAO =
    Bind<SettingsDAO>((i) => SettingsInMemoryDAO(), lazy: false);
final Bind DI_IN_MEM_WEEK_CACHE =
    Bind<WeekCacheDAO>((i) => WeekCacheInMemoryDAO());

final List<Bind> IN_MEMORY_DAO_INJECTIONS = [
  DI_IN_MEM_GAMES_DAO,
  DI_IN_MEM_SETTINGS_DAO,
  DI_IN_MEM_TEAMS_DAO,
  DI_IN_MEM_WEEK_CACHE,
];
