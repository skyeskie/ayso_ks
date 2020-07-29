import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/game.dart';
import '../games.dart';

class GamesSpDAO implements GamesDAO {
  GamesSpDAO() {
    prefsFuture = GetIt.I.getAsync<SharedPreferences>()
      ..then((sp) {
        prefs = sp;
      });
  }
  Future<SharedPreferences> prefsFuture;
  SharedPreferences prefs;

  static const String GAMES_KEY = 'all_games';

  @override
  Future add(Iterable<Game> games) {
    final savedGames = prefs.getStringList(GAMES_KEY) ?? <String>[];
    final savedIds =
        savedGames.map(Game.fromJsonString).map((game) => game.id).toSet();

    final savedGameMap = Map.fromIterables(savedIds, savedGames);

    for (final game in games) {
      savedGameMap[game.id] = jsonEncode(game);
    }

    return prefs.setStringList(GAMES_KEY, savedGameMap.values.toList());
  }

  @override
  Future<void> clear() {
    return prefs.remove(GAMES_KEY);
  }

  @override
  Future<Iterable<Game>> findForTeam(String teamId) {
    final games = prefs.getStringList(GAMES_KEY)?.map(Game.fromJsonString);
    if (games == null) return Future.value([]);
    return Future.value(games.where((game) => game.hasTeam(teamId)));
  }

  @override
  Future<Iterable<Game>> findForTeams(Iterable<String> teamIds) {
    final games = prefs.getStringList(GAMES_KEY)?.map(Game.fromJsonString);
    if (games == null) return Future.value([]);
    final teams = teamIds.toSet();
    return Future.value(games.where(
        (game) => teams.contains(game.home) || teams.contains(game.away)));
  }

  @override
  Future<Iterable<Game>> findGames(
      {int regionId, String ageGroup, String gender, int week}) {
    final games = prefs.getStringList(GAMES_KEY)?.map(Game.fromJsonString);
    if (games == null) return Future.value([]);
    return Future.value(games.where((game) =>
        (regionId == null || game.region?.number == regionId) &&
        (ageGroup == null || game.division?.age?.toString() == ageGroup) &&
        (gender == null || game.division?.gender?.long == gender) &&
        (week == null || game.weekNum == week)));
  }

  @override
  Future<Game> getGame(String id) {
    final games = prefs.getStringList(GAMES_KEY)?.map(Game.fromJsonString);
    if (games == null) return Future.value(null);
    final matched = games.where((game) => game.id == id);
    return Future.value(matched.length == 1 ? matched.first : null);
  }
}
