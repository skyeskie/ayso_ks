import 'dart:convert';

import 'package:meta/meta.dart';

import 'division.dart';
import 'region.dart';

/// Data class describing information for a team
class Team {
  /// Constructor
  Team({
    @required this.code,
    @required this.coach,
    @required this.coachTel,
    this.division,
    this.region,
  });

  /// Constructor for a team using the BYE code
  Team.bye() : this(code: BYE_CODE, coach: '', coachTel: '');

  /// Create from a JSON Map - suitable for use with convert library
  ///
  /// Complex type specifications:
  /// - Region is specified as integer region number
  /// - Division is specified as short string (see Division.shortDisplayName)
  factory Team.fromJson(Map<String, dynamic> map) {
    return Team(
      code: map['code'] as String,
      coach: map['coach'] as String,
      coachTel: map['coachTel'] as String,
      division: Division.fromString(map['division'] as String),
      region: Region.fromNumber(map['region'] as int),
    );
  }

  /// Create from a JSON String
  ///
  /// See [Team.fromJson] for more information.
  /// This is specified as a static method so it can be used as a tearoff when
  /// running map over an iterable
  // ignore: prefer_constructors_over_static_methods
  static Team fromJsonString(String jsonString) {
    final jsonMap = jsonDecode(jsonString);
    return Team.fromJson(jsonMap);
  }

  /// Convert to JSON map
  ///
  /// See [Team.fromJson] for information on complex types
  Map<String, dynamic> toJson() => {
        'code': code,
        'coach': coach,
        'coachTel': coachTel,
        'division': division.shortDisplayName(),
        'region': region.number,
      };

  /// Code for a bye team
  ///
  /// This is a dummy team that other teams 'face' for a bye
  static const String BYE_CODE = '-';

  /// Unique identifier for a team
  String code;

  /// Name of the team's coach
  String coach;

  /// Telephone for contacting the coach
  String coachTel;

  /// Division the team plays in
  Division division;

  /// Home region for the team
  Region region;
}
