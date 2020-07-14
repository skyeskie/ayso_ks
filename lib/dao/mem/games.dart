import '../../models/game.dart';
import '../games.dart';

class GamesInMemoryDAO implements GamesDAO {
  GamesInMemoryDAO({Iterable<Game> init}) {
    if (init != null) {
      _games.addEntries(toEntries(init));
    }
  }

  final Map<String, Game> _games = {};

  static Iterable<MapEntry<String, Game>> toEntries(Iterable<Game> games) {
    return games.map((game) => MapEntry<String, Game>(game.id, game));
  }

  @override
  Future add(Iterable<Game> games) {
    _games.addEntries(toEntries(games));
    return Future.value(_games.length);
  }

  @override
  Future<void> clear() {
    _games.clear();
    return Future.value(_games.length);
  }

  @override
  Future<Iterable<Game>> findForTeam(String teamId) {
    return Future.value(_games.values.where((game) => game.hasTeam(teamId)));
  }

  @override
  Future<Iterable<Game>> findForTeams(Iterable<String> teamIds) {
    final teams = teamIds.toSet();
    return Future.value(_games.values.where((game) =>
        (teams.contains(game.home.code) || teams.contains(game.away.code))));
  }

  @override
  Future<Iterable<Game>> findGames({
    int regionId,
    String ageGroup,
    String gender,
    int week,
  }) {
    return Future.value(_games.values
        .where((game) => (regionId == null || game.region.number == regionId))
        .where((game) =>
            (ageGroup == null || game.division.age.toString() == ageGroup))
        .where(
            (game) => (gender == null || game.division.gender.long == gender))
        .where((game) => (week == null || game.weekNum == week)));
  }

  @override
  Future<Game> getGame(String id) {
    return Future.value(_games[id]);
  }
}
