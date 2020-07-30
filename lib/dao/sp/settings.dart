import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/region.dart';
import '../../models/team.dart';
import '../settings.dart';
import '../teams.dart';

/// Implementation of Settings DAO using shared_preferences library
///
/// Suitable for Android and iOS
class SettingsSpDao implements SettingsDAO {
  /// Create object, initializing the SharedPreferences link
  SettingsSpDao() {
    prefsFuture = GetIt.I.getAsync<SharedPreferences>()
      ..then((sp) {
        _prefs = sp;
      });
  }

  /// Future for obtaining the SharedPreferences handle
  Future<SharedPreferences> prefsFuture;
  SharedPreferences _prefs;
  final TeamsDAO _teamsDAO = GetIt.I.get<TeamsDAO>();

  /// Shared preferences key used for storing favorite teams
  static const String TEAMS_KEY = 'favoriteTeams';

  /// Shared preferences key used for storing user region number
  static const String REGION_KEY = 'regionNumber';

  /// Shared preferences key used for storing data version
  static const String VERSION_KEY = 'dataVersion';

  @override
  Future<void> clearSavedTeams() {
    return Future.value(_prefs.setStringList(TEAMS_KEY, []));
  }

  @override
  Future<String> getDataVersion() {
    return Future.value(_prefs.getString(VERSION_KEY));
  }

  @override
  Future<Region> getRegion() async {
    final regionNumber = await getRegionNumber();
    if (regionNumber == null) return Future.value(null);
    return Future.value(Region.fromNumber(regionNumber));
  }

  @override
  Future<int> getRegionNumber() {
    if (!_prefs.containsKey(REGION_KEY)) return Future.value(null);
    return Future.value(_prefs.getInt(REGION_KEY));
  }

  @override
  Future<Iterable<String>> getSavedTeamIDs() {
    return Future.value(_prefs.getStringList(TEAMS_KEY));
  }

  @override
  Future<Iterable<Team>> getSavedTeams() {
    return getSavedTeamIDs().then(_teamsDAO.getTeams);
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
      _prefs.setInt(REGION_KEY, regionNum),
      _prefs.setStringList(TEAMS_KEY, savedTeams),
    ]);
  }

  @override
  bool isAppConfigured() {
    return _prefs.getInt(REGION_KEY) != null;
  }

  @override
  Future<bool> isTeamSaved(String teamId) {
    return Future.value(_prefs.getStringList(TEAMS_KEY).contains(teamId));
  }

  @override
  Future<void> reset() {
    return Future.wait([
      _prefs.remove(REGION_KEY),
      _prefs.remove(VERSION_KEY),
      clearSavedTeams(),
    ]);
  }

  @override
  Future<void> saveTeamId(String teamId) {
    final teams = _prefs.getStringList(TEAMS_KEY);

    if (!teams.contains(teamId)) {
      teams.add(teamId);
      return _prefs.setStringList(TEAMS_KEY, teams);
    }

    return Future.value();
  }

  @override
  Future setDataVersion(String version) {
    return _prefs.setString(VERSION_KEY, version);
  }

  @override
  Future<void> setRegion(int regionNum) {
    //Make sure can create the region
    Region.fromNumber(regionNum);

    return _prefs.setInt(REGION_KEY, regionNum);
  }

  @override
  Future<void> unSaveTeam(String teamId) async {
    final teams = _prefs.getStringList(TEAMS_KEY);

    if (teams.remove(teamId)) {
      return _prefs.setStringList(TEAMS_KEY, teams);
    }

    return Future.value();
  }
}
