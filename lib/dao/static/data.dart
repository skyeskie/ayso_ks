import 'package:time/time.dart';

import '../../models/division.dart';
import '../../models/game.dart';
import '../../models/region.dart';
import '../../models/team.dart';
import '../backend.dart';

// ignore: avoid_classes_with_only_static_members
class StaticData {
  static List<DateTime> weeks = [
    DateTime(2016, 1, 31),
    DateTime(2016, 2, 7),
    DateTime(2016, 2, 9),
    DateTime(2016, 3, 7),
  ];

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
  ];

  static SettingsDataType settings = SettingsDataType(
    regionNumber: 49,
    savedTeams: ['A', 'B', 'I'],
  );

  static List<Team> savedTeamsFull = [
    teams['A'],
    teams['B'],
    teams['I'],
  ];
}

DateTime startTime(int week, int hour) {
  final start = StaticData.weeks[week - 1];
  final end = StaticData.weeks[week] ?? start + 7.days;
  final sat = start.to(end).firstWhere(
        (d) => d.weekday == DateTime.saturday,
        orElse: () => start,
      );
  return sat + hour.hours;
}

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
    home: StaticData.teams[home],
    away: StaticData.teams[away],
    weekNum: weekNum,
    startTime: time,
    region: r(regionNum),
    field: field,
    division: d(divisionCode),
  );
}

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

Region r(int number) => Region.fromNumber(number);
Division d(String code) => Division.fromString(code);
