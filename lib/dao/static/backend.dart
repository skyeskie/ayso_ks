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
    return Future.value(games);
  }

  @override
  Future<SettingsDataType> getSettings() {
    return Future.value(settings);
  }

  @override
  Future<Iterable<Team>> getTeams() {
    return Future.value(teams);
  }

  @override
  Future<Iterable<DateTime>> getWeekStarts() {
    return Future.value(weeks);
  }

  @override
  Future init(String curVersion) {
    return Future.value();
  }
}
