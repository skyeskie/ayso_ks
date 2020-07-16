import 'package:flutter_modular/flutter_modular.dart';

import '../../models/region.dart';
import '../../models/team.dart';
import '../settings.dart';
import '../teams.dart';

class SettingsInMemoryDAO implements SettingsDAO {
  SettingsInMemoryDAO({SettingsDataType initData}) {
    if (initData?.savedTeams != null) {
      _teams.addAll(initData.savedTeams);
    }

    if (initData?.regionNumber != null) {
      _region = Region.fromNumber(initData.regionNumber);
    }
  }

  final Set<String> _teams = {};
  Region _region;

  final TeamsDAO _teamsDAO = Modular.get<TeamsDAO>();

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
  Future<void> init({num regionNum, Iterable<String> savedTeams}) {
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
    _region = Region.fromNumber(regionNum);
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
}
