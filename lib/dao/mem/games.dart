import '../../models/game.dart';
import '../games.dart';

/// In-memory implementation of the Games DAO
///
/// Does not persist between app runs
class GamesInMemoryDAO implements GamesDAO {
  /// Can optionally create with [init] list of games
  GamesInMemoryDAO({Iterable<Game> init}) {
    if (init != null) {
      _games.addEntries(toEntries(init));
    }
  }

  final Map<String, Game> _games = {};

  /// Transforms games so can put into a map, with Game ID as key
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
    return Future.value(_games.values.where(
        (game) => (teams.contains(game.home) || teams.contains(game.away))));
  }

  @override
  Future<Iterable<Game>> findGames({
    int regionNum,
    String ageGroup,
    String gender,
    int week,
  }) {
    return Future.value(_games.values.where((game) =>
        (regionNum == null || game.region?.number == regionNum) &&
        (ageGroup == null || game.division?.age?.toString() == ageGroup) &&
        (gender == null || game.division?.gender?.long == gender) &&
        (week == null || game.weekNum == week)));
  }

  @override
  Future<Game> getGame(String id) {
    return Future.value(_games[id]);
  }
}
