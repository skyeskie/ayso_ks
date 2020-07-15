import '../../models/team.dart';
import '../teams.dart';

class TeamsInMemoryDAO implements TeamsDAO {
  TeamsInMemoryDAO({Iterable<Team> init}) {
    if (init != null) {
      _teams.addEntries(toEntries(init));
    }
  }

  final Map<String, Team> _teams = {};

  static Iterable<MapEntry<String, Team>> toEntries(Iterable<Team> teams) {
    return teams.map((e) => MapEntry<String, Team>(e.code, e));
  }

  @override
  Future add(Iterable<Team> teams) {
    _teams.addEntries(toEntries(teams));
    return Future.value(_teams.length);
  }

  @override
  Future<void> clear() {
    _teams.clear();
    return Future.value(_teams.length);
  }

  @override
  Future<Iterable<Team>> findTeams({
    int regionNumber,
    String ageString,
    String genderLong,
  }) {
    return Future.value(_teams.values
        .where((t) => (regionNumber == null || t.region.number == regionNumber))
        .where((t) =>
            (ageString == null || t.division.age.toString() == ageString))
        .where((t) =>
            (genderLong == null || t.division.gender.long == genderLong)));
  }

  @override
  Future<Team> getTeam(String id) {
    return Future.value(_teams[id]);
  }

  @override
  Future<Iterable<Team>> getTeams(Iterable<String> ids) {
    return Future.value(ids.map((id) => _teams[id]).where((e) => e != null));
  }
}
