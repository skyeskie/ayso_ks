import '../../models/game.dart';
import '../../models/team.dart';
import '../backend.dart';
import 'data.dart';

class BackendStatic implements Backend {
  @override
  Future<String> getDataVersion() {
    return Future.value('static');
  }

  @override
  Future<Iterable<Game>> getGames() {
    return Future.value(StaticData.games);
  }

  @override
  Future<SettingsDataType> getSettings() {
    return Future.value(StaticData.settings);
  }

  @override
  Future<Iterable<Team>> getTeams() {
    return Future.value(StaticData.teams.values);
  }

  @override
  Future<Iterable<DateTime>> getWeekStarts() {
    return Future.value(StaticData.weeks);
  }

  @override
  Future init(String curVersion) {
    return Future.value();
  }
}
