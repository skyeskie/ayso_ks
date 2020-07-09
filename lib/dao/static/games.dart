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
    return Future.value(games
        .where((game) => (game.weekNum == week))
        .where((game) => (region == null || game.region == region)));
  }

  @override
  Future<Iterable<Game>> findForTeam(String teamId) {
    return Future.value(games.where((game) => game.hasTeam(teamId)));
  }

  @override
  Future<Iterable<Game>> findForTeams(Iterable<String> teamIds) {
    final teams = teamIds.toSet();
    return Future.value(games.where(
        (game) => (teams.contains(game.home) || teams.contains(game.away))));
  }

  @override
  Future<Iterable<Game>> findGames({
    int regionId,
    String ageGroup,
    String gender,
    int week,
  }) {
    return Future.value(games
        .where((game) => (regionId == null || game.region.id == regionId))
        .where((game) =>
            (ageGroup == null || game.division.age.toString() == ageGroup))
        .where(
            (game) => (gender == null || game.division.gender.long == gender))
        .where((game) => (week == null || game.weekNum == week)));
  }

  @override
  Future<Game> getGame(String id) {
    return Future.value(games.firstWhere((game) => game.id == id));
  }
}