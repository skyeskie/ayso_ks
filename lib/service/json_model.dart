import 'dart:convert';

import 'package:tuple/tuple.dart';

import '../models/division.dart';
import '../models/game.dart';
import '../models/region.dart';
import '../models/team.dart';

class JsonModel {
  JsonModel.fromJson(Map<String, dynamic> jsonMap) {
    version = jsonMap['Version'];
    error = jsonMap['Error'];

    teams = [];
    final coaches = jsonMap['Coaches'] as Iterable;
    for (final coach in coaches) {
      teams.add(Team(
        code: coach['TeamNo'],
        coach: coach['Coach'],
        coachTel: coach['Phone'],
        division: Division.fromIdString(coach['Divis']),
        region: parseRegion(coach['TeamNo']),
      ));
    }

    games = [];
    final jsonGames = jsonMap['Games'] as Iterable;
    for (final game in jsonGames) {
      final fieldParts = parseGameField(game['Field']);
      games.add(Game(
        id: game['ID'],
        home: game['Home'],
        away: game['Away'],
        weekNum: parseWeek(game['Week']),
        startTime: DateTime.parse('${game['Jour']} ${game['Heur']}'),
        region: fieldParts.item1,
        field: fieldParts.item2,
      ));
    }
  }

  JsonModel.fromJsonString(String jsonString)
      : this.fromJson(jsonDecode(jsonString));

  static Future<JsonModel> parse(String jsonString) =>
      Future.value(JsonModel.fromJsonString(jsonString));

  String version;
  String error;
  List<Game> games;
  List<Team> teams;

  Region parseRegion(String teamId) {
    final id = int.tryParse(teamId.substring(0, 1), radix: 10);
    if (id == null) {
      print('Could not parse $teamId');
      return null;
    }
    return Region.fromId(id);
  }

  int parseWeek(String week) {
    return int.tryParse(week, radix: 10);
  }

  static final RegExp _fieldMatcher = RegExp(r'^(\d*) ?(Field)? ?(.*)$');
  static Tuple2<Region, String> parseGameField(String gameField) {
    final fieldParts = _fieldMatcher.firstMatch(gameField);

    Region region;
    if (fieldParts.group(1).isNotEmpty) {
      final regionNum = int.tryParse(fieldParts.group(1), radix: 10);
      if (regionNum != null) {
        region = Region.fromNumber(regionNum);
      }
    }

    return Tuple2(region, fieldParts.group(3));
  }
}
