import '../../models/game.dart';
import '../games.dart';
import 'data.dart';

class GamesStaticDAO implements GamesDAO {
  @override
  Future add(Iterable<Game> games) {
    return Future.value();
  }

  @override
  Future<void> clear() {
    return Future.value();
  }

  @override
  Future<Iterable<Game>> findByWeek(int week, {int region}) {
    return Future.value(StaticData.games
        .where((game) => (game.weekNum == week))
        .where((game) => (region == null || game.region == region)));
  }

  @override
  Future<Iterable<Game>> findForTeam(String teamId) {
    return Future.value(StaticData.games.where((game) => game.hasTeam(teamId)));
  }

  @override
  Future<Iterable<Game>> findForTeams(Iterable<String> teamIds) {
    final teams = teamIds.toSet();
    return Future.value(StaticData.games.where((game) =>
        (teams.contains(game.home.code) || teams.contains(game.away.code))));
  }

  @override
  Future<Iterable<Game>> findGames({
    int regionId,
    String ageGroup,
    String gender,
    int week,
  }) {
    return Future.value(StaticData.games
        .where((game) => (regionId == null || game.region.number == regionId))
        .where((game) =>
            (ageGroup == null || game.division.age.toString() == ageGroup))
        .where(
            (game) => (gender == null || game.division.gender.long == gender))
        .where((game) => (week == null || game.weekNum == week)));
  }

  @override
  Future<Game> getGame(String id) {
    return Future.value(StaticData.games.firstWhere((game) => game.id == id));
  }
}
