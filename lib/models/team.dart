import 'package:meta/meta.dart';

import 'division.dart';
import 'region.dart';

class Team {
  String code;
  String coach;
  String coachTel;
  Division division;
  Region region;

  Team({
    @required this.code,
    @required this.coach,
    @required this.coachTel,
    this.division,
    this.region,
  });
}
