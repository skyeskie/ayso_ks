import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/region.dart';
import '../../models/team.dart';
import '../settings.dart';
import '../teams.dart';

class SettingsSpDao implements SettingsDAO {
  SettingsSpDao() {
    prefsFuture = GetIt.I.getAsync<SharedPreferences>()
      ..then((sp) {
        prefs = sp;
      });
  }

  Future<SharedPreferences> prefsFuture = GetIt.I.getAsync<SharedPreferences>();
  SharedPreferences prefs;
  TeamsDAO teamsDAO = GetIt.I.get<TeamsDAO>();

  static const String TEAMS_KEY = 'favoriteTeams';

  static const String REGION_KEY = 'regionNumber';

  static const String VERSION_KEY = 'dataVersion';

  bool appInit = false;

  @override
  Future<void> clearSavedTeams() {
    return Future.value(prefs.setStringList(TEAMS_KEY, []));
  }

  @override
  Future<String> getDataVersion() {
    return Future.value(prefs.getString(VERSION_KEY));
  }

  @override
  Future<Region> getRegion() async {
    final regionNumber = await getRegionNumber();
    if (regionNumber == null) return Future.value(null);
    return Future.value(Region.fromNumber(regionNumber));
  }

  @override
  Future<int> getRegionNumber() {
    if (!prefs.containsKey(REGION_KEY)) return Future.value(null);
    return Future.value(prefs.getInt(REGION_KEY));
  }

  @override
  Future<Iterable<String>> getSavedTeamIDs() {
    return Future.value(prefs.getStringList(TEAMS_KEY));
  }

  @override
  Future<Iterable<Team>> getSavedTeams() {
    return getSavedTeamIDs().then((ids) => teamsDAO.getTeams(ids));
  }

  @override
  Future<SettingsDataType> getSettingsReadonly() async {
    return SettingsDataType(
      savedTeams: await getSavedTeamIDs(),
      regionNumber: await getRegionNumber(),
    );
  }

  @override
  Future<void> init({num regionNum, Iterable<String> savedTeams}) {
    return Future.wait([
      prefs.setInt(REGION_KEY, regionNum),
      prefs.setStringList(TEAMS_KEY, savedTeams),
    ]);
  }

  @override
  bool isAppConfigured() {
    return prefs.getInt(REGION_KEY) != null;
  }

  @override
  Future<bool> isTeamSaved(String teamId) {
    return Future.value(prefs.getStringList(TEAMS_KEY).contains(teamId));
  }

  @override
  Future<void> reset() {
    return Future.wait([
      prefs.remove(REGION_KEY),
      prefs.remove(VERSION_KEY),
      clearSavedTeams(),
    ]);
  }

  @override
  Future<void> saveTeamId(String teamId) {
    final teams = prefs.getStringList(TEAMS_KEY);

    if (!teams.contains(teamId)) {
      teams.add(teamId);
      return prefs.setStringList(TEAMS_KEY, teams);
    }

    return Future.value();
  }

  @override
  Future setDataVersion(String version) {
    return prefs.setString(VERSION_KEY, version);
  }

  @override
  Future<void> setRegion(int regionNum) {
    //Make sure can create the region
    Region.fromNumber(regionNum);

    return prefs.setInt(REGION_KEY, regionNum);
  }

  @override
  Future<void> unSaveTeam(String teamId) async {
    final teams = prefs.getStringList(TEAMS_KEY);

    if (teams.remove(teamId)) {
      return prefs.setStringList(TEAMS_KEY, teams);
    }

    return Future.value();
  }
}
