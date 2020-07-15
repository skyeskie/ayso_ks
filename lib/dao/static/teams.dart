import '../../models/team.dart';
import '../teams.dart';
import 'data.dart';

class TeamsStaticDAO implements TeamsDAO {
  @override
  Future add(Iterable<Team> teams) {
    return Future.value();
  }

  @override
  Future<void> clear() {
    return Future.value();
  }

  @override
  Future<Iterable<Team>> findTeams({
    int regionNumber,
    String ageString,
    String genderLong,
  }) {
    return Future.value(StaticData.teams.values
        .where((t) => (regionNumber == null || t.region.number == regionNumber))
        .where((t) =>
            (ageString == null || t.division.age.toString() == ageString))
        .where((t) =>
            (genderLong == null || t.division.gender.long == genderLong)));
  }

  @override
  Future<Team> getTeam(String id) {
    return Future.value(StaticData.teams[id]);
  }

  @override
  Future<Iterable<Team>> getTeams(Iterable<String> ids) {
    return Future.value(
      ids.map((id) => StaticData.teams[id]).where((e) => e != null),
    );
  }
}
