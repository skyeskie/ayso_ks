import 'dart:convert';

import 'package:tuple/tuple.dart';

import '../models/division.dart';
import '../models/game.dart';
import '../models/region.dart';
import '../models/team.dart';

/// Auxiliary class for use with backends that process a JSON file
class JsonModel {
  /// Parse the map into data models of [Team] and [Game]
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
        weekNum: int.tryParse(game['Week'], radix: 10),
        startTime: DateTime.parse('${game['Jour']} ${game['Heur']}'),
        region: fieldParts.item1,
        field: fieldParts.item2,
      ));
    }
  }

  /// Parse JSON String into models using [json] library
  JsonModel.fromJsonString(String jsonString)
      : this.fromJson(jsonDecode(jsonString));

  /// Convenience function to wrap [JsonModel.fromJsonString] in a Future
  static Future<JsonModel> parse(String jsonString) =>
      Future.value(JsonModel.fromJsonString(jsonString));

  /// String version code - DataVersion
  String version;

  /// Error message if JSON file is malformed - or if there are server errors
  String error;

  /// Parsed models of the games from the file
  List<Game> games;

  /// Parsed models of the teams from the file
  List<Team> teams;

  /// Helper function to create the region from the [Team.code]
  ///
  /// Note: This is based on the first digit in the team code
  /// and looked up as an ID from [Region.REGIONS]
  Region parseRegion(String teamId) {
    final id = int.tryParse(teamId.substring(0, 1), radix: 10);
    if (id == null) {
      print('Could not parse $teamId');
      return null;
    }
    return Region.fromId(id);
  }

  static final RegExp _fieldMatcher = RegExp(r'^(\d*) ?(Field)? ?(.*)$');

  /// Helper function to parse the location for a game into region and field
  ///
  /// This expects the game location to be of the form:
  ///  "{region number} Field {description}", where the 'Field' text is optional
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
