import '../../models/region.dart';
import '../../models/team.dart';
import '../settings.dart';
import 'data.dart';

class SettingsStaticDAO implements SettingsDAO {
  @override
  Future<void> clearSavedTeams() {
    return Future.value();
  }

  @override
  Future<Region> getRegion() {
    return Future.value();
  }

  @override
  Future<int> getRegionNumber() {
    return Future.value(settings.regionNumber);
  }

  @override
  Future<Iterable<String>> getSavedTeamIDs() {
    return Future.value(settings.savedTeams);
  }

  @override
  Future<Iterable<Team>> getSavedTeams() {
    return Future.value(savedTeamsFull);
  }

  @override
  Future<void> init({num regionNum, Iterable<String> savedTeams}) {
    return Future.value();
  }

  @override
  bool isAppConfigured() {
    return true;
  }

  @override
  Future<bool> isTeamSaved(String teamId) {
    return Future.value(settings.savedTeams.contains(teamId));
  }

  @override
  Future<void> reset() {
    return Future.value();
  }

  @override
  Future<void> saveTeamId(String teamId) {
    return Future.value();
  }

  @override
  Future<void> setRegion(int regionNum) {
    return Future.value();
  }

  @override
  Future<void> unSaveTeam(String teamId) {
    return Future.value();
  }
}
