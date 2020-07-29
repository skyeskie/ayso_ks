import 'dart:convert';

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

  factory Team.fromJson(Map<String, dynamic> map) {
    return Team(
      code: map['code'] as String,
      coach: map['coach'] as String,
      coachTel: map['coachTel'] as String,
      division: Division.fromString(map['division'] as String),
      region: Region.fromNumber(map['region'] as int),
    );
  }

  // ignore: prefer_constructors_over_static_methods
  static Team fromJsonString(String jsonString) {
    final jsonMap = jsonDecode(jsonString);
    return Team.fromJson(jsonMap);
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'coach': coach,
        'coachTel': coachTel,
        'division': division.shortDisplayName(),
        'region': region.number,
      };

  static const String BYE_CODE = '-';

  String code;
  String coach;
  String coachTel;
  Division division;
  Region region;
}
