import 'package:ayso_ks/dao/settings.dart';
import 'package:ayso_ks/models/division.dart';
import 'package:ayso_ks/models/game.dart';
import 'package:ayso_ks/models/region.dart';
import 'package:ayso_ks/models/team.dart';
import 'package:time/time.dart';

// ignore: avoid_classes_with_only_static_members
class TestData {
  static List<DateTime> weeks = [
    DateTime(2016, 1, 31),
    DateTime(2016, 2, 7),
    DateTime(2016, 2, 9),
    DateTime(2016, 3, 7),
  ];

  static final Map<String, Team> teams = {
    'A': mkTeam('A', 'coachA', 'telA', 'U10B', 49),
    'B': mkTeam('B', 'coachB', 'telB', 'U10B', 49),
    'C': mkTeam('C', 'coachC', 'telC', 'U10B', 208),
    'D': mkTeam('D', 'coachD', 'telD', 'U10B', 208),
    'E': mkTeam('E', 'coachE', 'telE', 'U10G', 49),
    'F': mkTeam('F', 'coachA', 'telA', 'U12G', 49),
    'G': mkTeam('G', 'coachG', 'telG', 'U12G', 208),
    'H': mkTeam('H', 'coachH', 'telH', 'U12G', 49),
    'I': mkTeam('I', 'coachI', 'telI', 'U12G', 49),
    'J': mkTeam('J', 'coachJ', 'telJ', 'U12B', 49),
  };

  static final List<Game> games = [
    mkGame('111', 'A', 'B', 1, startTime(1, 8), 49, 'map', 'U10B'),
    mkGame('112', 'C', 'D', 1, startTime(1, 8), 49, 'map2', 'U10B'),
    mkGame('121', 'A', 'C', 1, startTime(1, 10), 49, 'map', 'U10B'),
    mkGame('122', 'B', 'D', 1, startTime(1, 10), 49, 'map2', 'U10B'),
    mkGame('231', 'A', 'D', 2, startTime(2, 12), 208, 'map', 'U10B'),
    mkGame('232', 'C', 'B', 2, startTime(2, 12), 208, 'map2', 'U10B'),
    mkGame('311', 'E', 'H', 1, startTime(1, 8), 49, 'map', 'U12G'),
    mkGame('312', 'I', 'J', 1, startTime(1, 8), 49, 'map2', 'U12G'),
    mkGame('321', 'E', 'I', 1, startTime(1, 10), 49, 'map', 'U12G'),
    mkGame('322', 'H', 'J', 1, startTime(1, 10), 49, 'map2', 'U12G'),
    mkGame('431', 'E', 'J', 2, startTime(2, 12), 208, 'map', 'U12G'),
    mkGame('432', 'I', 'H', 2, startTime(2, 12), 208, 'map2', 'U12G'),
    mkGame('501', 'A', '-', 3, startTime(3, 8), 49, null, 'U10B'),
    mkGame('502', '-', 'B', 3, startTime(3, 8), 49, null, 'U10B'),
  ];

  static SettingsDataType settings = SettingsDataType(
    regionNumber: 49,
    savedTeams: ['A', 'B', 'I'],
    dataVersion: 'test-version',
  );

  static List<Team> savedTeamsFull = [
    teams['A'],
    teams['B'],
    teams['I'],
  ];

  ///Short make team
  static Team mkTeam(
    String code,
    String coach,
    String coachTel,
    String divisionCode,
    int regionNum,
  ) {
    if (code == Team.BYE_CODE) {
      return Team.bye();
    }

    return Team(
      code: code,
      coach: coach,
      coachTel: coachTel,
      division: Division.fromString(divisionCode),
      region: Region.fromNumber(regionNum),
    );
  }

  ///Long form of make team so can label fields
  static Team makeTeam({
    String code,
    String coach,
    String coachTel,
    String divisionCode,
    int regionNum,
  }) =>
      mkTeam(code, coach, coachTel, divisionCode, regionNum);

  static DateTime startTime(int week, int hour) {
    final start = weeks[week - 1];
    final end = weeks[week] ?? start + 7.days;
    var diffSat = DateTime.saturday - start.weekday;
    if (diffSat < 0) diffSat += 7;
    var day = start + diffSat.days;
    if (end.isBefore(day)) day = start;
    return day + hour.hours;
  }

  static Game mkGame(
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
      region: Region.fromNumber(regionNum),
      field: field,
      division: Division.fromString(divisionCode),
    );
  }

  static Game makeGame({
    String id,
    String home,
    String away,
    int weekNum,
    DateTime time,
    int regionNum,
    String field,
    String divisionCode,
  }) =>
      mkGame(id, home, away, weekNum, time, regionNum, field, divisionCode);
}
