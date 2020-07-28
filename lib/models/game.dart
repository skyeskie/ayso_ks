import 'dart:convert';

import 'package:meta/meta.dart';

import 'division.dart';
import 'region.dart';

class Game {
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

  factory Game.fromJson(Map<String, dynamic> map) {
    return Game(
      id: map['id'] as String,
      home: map['home'] as String,
      away: map['away'] as String,
      weekNum: map['weekNum'] as int,
      startTime: DateTime.fromMicrosecondsSinceEpoch(map['startTime'] as int),
      region: Region.fromNumber(map['region'] as int),
      field: map['field'] as String,
      division: Division.fromString(map['division']),
    );
  }

  // ignore: prefer_constructors_over_static_methods
  static Game fromJsonString(String jsonString) {
    final jsonMap = jsonDecode(jsonString);
    return Game.fromJson(jsonMap);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'home': home,
        'away': away,
        'weekNum': weekNum,
        'startTime': startTime.millisecondsSinceEpoch,
        'region': region.number,
        'field': field,
        'division': division?.shortDisplayName(),
      };

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
}
