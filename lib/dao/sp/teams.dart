import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/team.dart';
import '../teams.dart';

/// Implementation of Teams DAO using shared_preferences library
///
/// Suitable for Android and iOS
/// Data is stored unstructured and must be read in its entirety for operations
class TeamsSpDAO implements TeamsDAO {
  /// Create object, initializing the SharedPreferences link
  TeamsSpDAO() {
    prefsFuture = GetIt.I.getAsync<SharedPreferences>()
      ..then((sp) {
        _prefs = sp;
      });
  }

  /// Future for obtaining the SharedPreferences handle
  Future<SharedPreferences> prefsFuture;
  SharedPreferences _prefs;

  /// Shared preferences key used for storing teams
  static const String TEAMS_KEY = 'all_teams';

  @override
  Future add(Iterable<Team> teams) {
    final allTeams = _prefs.getStringList(TEAMS_KEY);
    final allIds = allTeams.map(Team.fromJsonString).map((t) => t.code).toSet();

    final teamsMap = Map.fromIterables(allIds, allTeams);

    for (final team in teams) {
      teamsMap[team.code] = jsonEncode(team);
    }

    return _prefs.setStringList(TEAMS_KEY, teamsMap.values.toList());
  }

  @override
  Future<void> clear() {
    return _prefs.remove(TEAMS_KEY);
  }

  @override
  Future<Iterable<Team>> findTeams({
    int regionNumber,
    String ageString,
    String genderLong,
  }) {
    final teamsJson = _prefs.getStringList(TEAMS_KEY) ?? [];
    final teams = teamsJson.map(Team.fromJsonString);
    return Future.value(teams.where((team) =>
        (regionNumber == null || team.region?.number == regionNumber) &&
        (ageString == null || team.division?.age?.toString() == ageString) &&
        (genderLong == null || team.division?.gender?.long == genderLong)));
  }

  @override
  Future<Team> getTeam(String id) {
    final teamsJson = _prefs.getStringList(TEAMS_KEY) ?? [];
    final matches =
        teamsJson.map(Team.fromJsonString).where((team) => team.code == id);
    return (matches.length == 1)
        ? Future.value(matches.first)
        : Future.value(null);
  }

  @override
  Future<Iterable<Team>> getTeams(Iterable<String> ids) {
    final teamsJson = _prefs.getStringList(TEAMS_KEY) ?? [];
    final idSet = ids.toSet();
    return Future.value(teamsJson
        .map(Team.fromJsonString)
        .where((team) => idSet.contains(team.code)));
  }
}
