import 'package:meta/meta.dart';

import 'division.dart';
import 'region.dart';

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
  String home;
  String away;
  int weekNum;
  DateTime startTime;
  Region region;
  String field;
  Division division;

  bool hasTeam(String teamId) {
    return home == teamId || away == teamId;
  }

  String getOpponent(String teamId) {
    if (teamId == home) return away;
    if (teamId == away) return home;
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
