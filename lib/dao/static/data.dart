import 'package:time/time.dart';

import '../../models/division.dart';
import '../../models/game.dart';
import '../../models/region.dart';
import '../../models/team.dart';
import '../backend.dart';

final List<DateTime> weeks = [
  DateTime(2016, 1, 31),
  DateTime(2016, 2, 7),
  DateTime(2016, 2, 9),
  DateTime(2016, 3, 7),
];

final List<Team> teams = [
  mt('A', 'coachA', 'telA', 'U10B', 49),
  mt('B', 'coachB', 'telB', 'U10B', 49),
  mt('C', 'coachC', 'telC', 'U10B', 208),
  mt('D', 'coachD', 'telD', 'U10B', 208),
  mt('E', 'coachE', 'telE', 'U10G', 49),
  mt('F', 'coachA', 'telA', 'U12G', 49),
  mt('G', 'coachG', 'telG', 'U12G', 208),
  mt('H', 'coachH', 'telH', 'U12G', 49),
  mt('I', 'coachI', 'telI', 'U12G', 49),
  mt('J', 'coachJ', 'telJ', 'U12B', 49),
];

final List<Game> games = [
  g('111', 'A', 'B', 1, startTime(0, 8), 49, 'map', 'U10B'),
  g('112', 'C', 'D', 1, startTime(0, 8), 49, 'map2', 'U10B'),
  g('121', 'A', 'C', 1, startTime(0, 10), 49, 'map', 'U10B'),
  g('122', 'B', 'D', 1, startTime(0, 10), 49, 'map2', 'U10B'),
  g('231', 'A', 'D', 2, startTime(1, 12), 208, 'map', 'U10B'),
  g('232', 'C', 'B', 2, startTime(1, 12), 208, 'map2', 'U10B'),
  g('311', 'E', 'H', 1, startTime(0, 8), 49, 'map', 'U12G'),
  g('312', 'I', 'J', 1, startTime(0, 8), 49, 'map2', 'U12G'),
  g('321', 'E', 'I', 1, startTime(0, 10), 49, 'map', 'U12G'),
  g('322', 'H', 'J', 1, startTime(0, 10), 49, 'map2', 'U12G'),
  g('431', 'E', 'J', 2, startTime(1, 12), 208, 'map', 'U12G'),
  g('432', 'I', 'H', 2, startTime(1, 12), 208, 'map2', 'U12G'),
];

final SettingsDataType settings = SettingsDataType(
  regionNumber: 49,
  savedTeams: [
    teams[0].code,
    teams[1].code,
    teams[8].code,
  ],
);

final List<Team> savedTeamsFull = [
  teams[0],
  teams[1],
  teams[8],
];

DateTime startTime(int week, int hour) {
  final start = weeks[week - 1];
  final end = weeks[week] ?? DateTime.now();
  final sat = start.to(end).firstWhere((d) => d.weekday == DateTime.saturday);
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
    home: home,
    away: away,
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
