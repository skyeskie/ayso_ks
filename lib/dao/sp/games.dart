import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/game.dart';
import '../games.dart';

/// Implementation of Games DAO using shared_preferences library
///
/// Suitable for Android and iOS
/// Data is stored unstructured and must be read in its entirety for operations
class GamesSpDAO implements GamesDAO {
  /// Create object, initializing the SharedPreferences link
  GamesSpDAO() {
    prefsFuture = GetIt.I.getAsync<SharedPreferences>()
      ..then((sp) {
        _prefs = sp;
      });
  }

  /// Future for obtaining the SharedPreferences handle
  Future<SharedPreferences> prefsFuture;
  SharedPreferences _prefs;

  /// Shared preferences key used for storing games
  static const String GAMES_KEY = 'all_games';

  @override
  Future add(Iterable<Game> games) {
    final savedGames = _prefs.getStringList(GAMES_KEY) ?? <String>[];
    final savedIds =
        savedGames.map(Game.fromJsonString).map((game) => game.id).toSet();

    final savedGameMap = Map.fromIterables(savedIds, savedGames);

    for (final game in games) {
      savedGameMap[game.id] = jsonEncode(game);
    }

    return _prefs.setStringList(GAMES_KEY, savedGameMap.values.toList());
  }

  @override
  Future<void> clear() {
    return _prefs.remove(GAMES_KEY);
  }

  @override
  Future<Iterable<Game>> findForTeam(String teamId) {
    final games = _prefs.getStringList(GAMES_KEY)?.map(Game.fromJsonString);
    if (games == null) return Future.value([]);
    return Future.value(games.where((game) => game.hasTeam(teamId)));
  }

  @override
  Future<Iterable<Game>> findForTeams(Iterable<String> teamIds) {
    final games = _prefs.getStringList(GAMES_KEY)?.map(Game.fromJsonString);
    if (games == null) return Future.value([]);
    final teams = teamIds.toSet();
    return Future.value(games.where(
        (game) => teams.contains(game.home) || teams.contains(game.away)));
  }

  @override
  Future<Iterable<Game>> findGames(
      {int regionNum, String ageGroup, String gender, int week}) {
    final games = _prefs.getStringList(GAMES_KEY)?.map(Game.fromJsonString);
    if (games == null) return Future.value([]);
    return Future.value(games.where((game) =>
        (regionNum == null || game.region?.number == regionNum) &&
        (ageGroup == null || game.division?.age?.toString() == ageGroup) &&
        (gender == null || game.division?.gender?.long == gender) &&
        (week == null || game.weekNum == week)));
  }

  @override
  Future<Game> getGame(String id) {
    final games = _prefs.getStringList(GAMES_KEY)?.map(Game.fromJsonString);
    if (games == null) return Future.value(null);
    final matched = games.where((game) => game.id == id);
    return Future.value(matched.length == 1 ? matched.first : null);
  }
}
