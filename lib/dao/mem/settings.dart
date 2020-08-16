import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../models/region.dart';
import '../../models/team.dart';
import '../settings.dart';
import '../teams.dart';

/// In-memory implementation of the Settings DAO
///
/// Does not persist between app runs
class SettingsInMemoryDAO implements SettingsDAO {
  /// Create DAO, optionally initializing with specific data
  ///
  /// isAppInitialized is determined on whether [regionNumber] is set
  SettingsInMemoryDAO({SettingsDataType initData}) {
    if (initData?.savedTeams != null) {
      _teams.addAll(initData.savedTeams);
    }

    if (initData?.regionNumber != null) {
      _region = Region.fromNumber(initData.regionNumber);
    }

    if (initData?.dataVersion != null) {
      _dataVersion = initData.dataVersion;
    }
  }

  final Set<String> _teams = {};
  Region _region;
  String _dataVersion;

  final TeamsDAO _teamsDAO = GetIt.I.get<TeamsDAO>();

  @override
  Future<void> clearSavedTeams() {
    _teams.clear();
    return Future.value(_teams.length);
  }

  @override
  Future<Region> getRegion() {
    return Future.value(_region);
  }

  @override
  Future<int> getRegionNumber() {
    return Future.value(_region?.number);
  }

  @override
  Future<Iterable<String>> getSavedTeamIDs() {
    return Future.value(_teams);
  }

  @override
  Future<Iterable<Team>> getSavedTeams() {
    return _teamsDAO.getTeams(_teams);
  }

  @override
  Future<void> init({@required num regionNum, Iterable<String> savedTeams}) {
    _region = Region.fromNumber(regionNum);
    _teams
      ..clear()
      ..addAll(savedTeams);
    return Future.value();
  }

  @override
  bool isAppConfigured() {
    return (_region != null);
  }

  @override
  Future<bool> isTeamSaved(String teamId) {
    return Future.value(_teams.contains(teamId));
  }

  @override
  Future<void> reset() {
    _region = null;
    _teams.clear();
    return Future.value();
  }

  @override
  Future<int> saveTeamId(String teamId) {
    _teams.add(teamId);
    return Future.value(_teams.length);
  }

  @override
  Future<int> setRegion(int regionNum) {
    _region = regionNum == null ? null : Region.fromNumber(regionNum);
    return Future.value(_region.number);
  }

  @override
  Future<void> unSaveTeam(String teamId) {
    _teams.remove(teamId);
    return Future.value(_teams.length);
  }

  @override
  Future<SettingsDataType> getSettingsReadonly() {
    return Future.value(SettingsDataType(
      regionNumber: _region?.number,
      savedTeams: _teams.toList(),
    ));
  }

  @override
  Future<String> getDataVersion() {
    return Future.value(_dataVersion);
  }

  @override
  Future setDataVersion(String version) {
    _dataVersion = version;
    return Future.value();
  }
}
