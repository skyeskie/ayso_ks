import 'package:meta/meta.dart';

import 'division.dart';
import 'region.dart';
import 'team.dart';

class Game implements Comparable {
  Game({
    @required this.id,
    @required this.home,
    @required this.away,
    @required this.weekNum,
    @required this.startTime,
    @required this.region,
    @required this.field,
    this.division,
  });

  static const BYE_TEAM = '-';

  String id;
  Team home;
  Team away;
  int weekNum;
  DateTime startTime;
  Region region;
  String field;
  Division division;

  bool hasTeam(String teamId) {
    return home.code == teamId || away.code == teamId;
  }

  String getOpponent(String teamId) {
    if (teamId == home.code) return away.code;
    if (teamId == away.code) return home.code;
    throw RangeError('Team "$teamId" is not playing in the game');
  }

  bool isBye() {
    return hasTeam(BYE_TEAM);
  }

  String getTeamWithBye() {
    return getOpponent(BYE_TEAM);
  }

  //Maybe not full Comparable ?
  @override
  int compareTo(dynamic other) {
    return startTime.millisecondsSinceEpoch -
        other.startTime.millisecondsSinceEpoch;
  }
}
