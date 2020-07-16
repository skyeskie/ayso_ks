import '../dao/static/data.dart';
import '../models/game.dart';
import '../models/team.dart';
import 'backend_interface.dart';

class BackendStatic implements BackendInterface {
  @override
  Future<Iterable<Game>> getGames() {
    return Future.value(StaticData.games);
  }

  @override
  Future<Iterable<Team>> getTeams() {
    return Future.value(StaticData.teams.values);
  }

  @override
  Future<Iterable<DateTime>> getWeekStarts() {
    return Future.value(StaticData.weeks);
  }
}
