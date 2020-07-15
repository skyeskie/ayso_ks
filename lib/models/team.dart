import 'package:meta/meta.dart';

import 'division.dart';
import 'region.dart';

class Team {
  Team({
    @required this.code,
    @required this.coach,
    @required this.coachTel,
    this.division,
    this.region,
  });

  Team.bye() : this(code: '-', coach: '', coachTel: '');

  static const String BYE_CODE = '-';

  String code;
  String coach;
  String coachTel;
  Division division;
  Region region;
}
