import 'dart:convert';

import 'package:meta/meta.dart';

import 'division.dart';
import 'region.dart';

/// Model for all information related to a single game
class Game {
  /// Constructor
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

  /// Create from a JSON Map - suitable for use with convert library
  ///
  /// Complex type specifications:
  /// - Time is specified as integer ms since epoch
  /// - Region is specified as integer region number
  /// - Division is specified as short string (see Division.shortDisplayName)
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

  /// Create from a JSON String
  ///
  /// See [Game.fromJson] for more information.
  /// This is specified as a static method so it can be used as a tearoff when
  /// running map over an iterable
  // ignore: prefer_constructors_over_static_methods
  static Game fromJsonString(String jsonString) {
    final jsonMap = jsonDecode(jsonString);
    return Game.fromJson(jsonMap);
  }

  /// Convert to JSON map
  ///
  /// See [Game.fromJson] for information on complex types
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

  /// Code used for a Bye (when a team is playing nobody)
  static const BYE_TEAM = '-';

  /// Game identification, for navigation and storage
  String id;

  /// ID string of the home team
  String home;

  /// ID string of the away team
  String away;

  /// Week number for the game
  int weekNum;

  /// Timestamp for the start of the game
  DateTime startTime;

  /// Region that is hosting the game
  ///
  /// Should match region of home team
  Region region;

  /// Description of which field the game is played on
  String field;

  /// Division the two teams belong to
  Division division;

  /// Returns true iff [teamId] is either the home team or away team
  bool hasTeam(String teamId) {
    return home == teamId || away == teamId;
  }

  /// Given one team playing, return the other team
  String getOpponent(String teamId) {
    if (teamId == home) return away;
    if (teamId == away) return home;
    throw RangeError('Team "$teamId" is not playing in the game');
  }

  /// True iff one of the teams has the [BYE_TEAM] code
  bool isBye() {
    return hasTeam(BYE_TEAM);
  }

  /// Return team that is not the [BYE_TEAM] in a bye game
  String getTeamWithBye() {
    return getOpponent(BYE_TEAM);
  }
}
