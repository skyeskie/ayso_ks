import '../dao/static/data.dart';
import '../models/game.dart';
import '../models/team.dart';
import 'backend_interface.dart';

/// Backend with data directly entered in code
///
/// This is primarily suitable for testing
class BackendStatic implements BackendInterface {
  @override
  Future<Iterable<Game>> getGames({String pastVersion}) {
    return Future.value(StaticData.games);
  }

  @override
  Future<Iterable<Team>> getTeams({String pastVersion}) {
    return Future.value(StaticData.teams.values);
  }

  @override
  Future<Iterable<DateTime>> getWeekStarts({String pastVersion}) {
    return Future.value(StaticData.weeks);
  }

  @override
  Future<String> getDataVersion({String pastVersion}) {
    return Future.value(StaticData.dataVersion);
  }
}
