import 'package:time/time.dart';

import '../../models/division.dart';
import '../../models/game.dart';
import '../../models/region.dart';
import '../../models/team.dart';
import '../settings.dart';

// ignore: avoid_classes_with_only_static_members
/// Data used by static DAO classes
class StaticData {
  /// DataVersion - fixed for static and not really used
  static const String dataVersion = 'static.1';

  /// Week starts, used by WeekCacheStaticDAO
  static List<DateTime> weeks = [
    DateTime(2016, 1, 31),
    DateTime(2016, 2, 7),
    DateTime(2016, 2, 9),
    DateTime(2016, 3, 7),
  ];

  /// Dummy teams that are used by TeamsStaticDAO
  static final Map<String, Team> teams = {
    'A': mt('A', 'coachA', 'telA', 'U10B', 49),
    'B': mt('B', 'coachB', 'telB', 'U10B', 49),
    'C': mt('C', 'coachC', 'telC', 'U10B', 208),
    'D': mt('D', 'coachD', 'telD', 'U10B', 208),
    'E': mt('E', 'coachE', 'telE', 'U10G', 49),
    'F': mt('F', 'coachA', 'telA', 'U12G', 49),
    'G': mt('G', 'coachG', 'telG', 'U12G', 208),
    'H': mt('H', 'coachH', 'telH', 'U12G', 49),
    'I': mt('I', 'coachI', 'telI', 'U12G', 49),
    'J': mt('J', 'coachJ', 'telJ', 'U12B', 49),
  };

  /// Games that are used by GamesStaticDAO
  static final List<Game> games = [
    g('111', 'A', 'B', 1, startTime(1, 8), 49, 'map', 'U10B'),
    g('112', 'C', 'D', 1, startTime(1, 8), 49, 'map2', 'U10B'),
    g('121', 'A', 'C', 1, startTime(1, 10), 49, 'map', 'U10B'),
    g('122', 'B', 'D', 1, startTime(1, 10), 49, 'map2', 'U10B'),
    g('231', 'A', 'D', 2, startTime(2, 12), 208, 'map', 'U10B'),
    g('232', 'C', 'B', 2, startTime(2, 12), 208, 'map2', 'U10B'),
    g('311', 'E', 'H', 1, startTime(1, 8), 49, 'map', 'U12G'),
    g('312', 'I', 'J', 1, startTime(1, 8), 49, 'map2', 'U12G'),
    g('321', 'E', 'I', 1, startTime(1, 10), 49, 'map', 'U12G'),
    g('322', 'H', 'J', 1, startTime(1, 10), 49, 'map2', 'U12G'),
    g('431', 'E', 'J', 2, startTime(2, 12), 208, 'map', 'U12G'),
    g('432', 'I', 'H', 2, startTime(2, 12), 208, 'map2', 'U12G'),
    g('501', 'A', '-', 3, startTime(3, 8), 49, null, 'U10B'),
    g('502', '-', 'B', 3, startTime(3, 8), 49, null, 'U10B'),
  ];

  /// Settings that are used by SettingsStaticDAO
  static SettingsDataType settings = SettingsDataType(
    regionNumber: 49,
    savedTeams: ['A', 'B', 'I'],
    dataVersion: 'static',
  );

  /// Full definition of the saved teams, used by SettingsStaticDAO
  static List<Team> savedTeamsFull = [
    teams['A'],
    teams['B'],
    teams['I'],
  ];
}

/// Calculate the start time given week number and hour
///
/// Will try to put it on Saturday, but if there isn't a Saturday between
/// two starts, will set it to the same day as the week start
DateTime startTime(int week, int hour) {
  final start = StaticData.weeks[week - 1];
  final end = StaticData.weeks[week] ?? start + 7.days;
  var diffSat = DateTime.saturday - start.weekday;
  if (diffSat < 0) diffSat += 7;
  var day = start + diffSat.days;
  if (end.isBefore(day)) day = start;
  return day + hour.hours;
}

/// Utility function for creating a Game
Game g(
  String id,
  String home,
  String away,
  int weekNum,
  DateTime time,
  int regionNum,
  String field,
  String divisionCode,
) {
  return Game(
    id: id,
    home: home,
    away: away,
    weekNum: weekNum,
    startTime: time,
    region: r(regionNum),
    field: field,
    division: d(divisionCode),
  );
}

/// Utility function for creating a Team
Team mt(
  String code,
  String coach,
  String coachTel,
  String divisionCode,
  int regionNum,
) {
  return Team(
    code: code,
    coach: coach,
    coachTel: coachTel,
    division: d(divisionCode),
    region: r(regionNum),
  );
}

/// Utility function for creating a region from region number
Region r(int number) => Region.fromNumber(number);

/// Utility function for creating a Division from string code
Division d(String code) => Division.fromString(code);
