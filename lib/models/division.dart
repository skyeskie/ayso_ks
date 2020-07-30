import 'package:meta/meta.dart';

import 'age_group.dart';
import 'gender.dart';

/// Data class indicating a particular division
///
/// A division consists of Age Group and Gender
class Division {
  /// Constant constructor.
  ///
  /// Avoid using this, it may disappear if switch to built_value enum-type
  Division({
    @required this.gender,
    @required this.age,
  });

  /// Create based on descriptive string
  ///
  /// String example: 'U10B', combining AgeGroup string and
  /// one character for gender
  Division.fromString(String display) {
    final matches = _fromString.firstMatch(display);
    if (matches == null) {
      throw ArgumentError('Invalid format for division code: "$display"');
    }
    age = AgeGroup.fromCutoff(int.parse(matches.group(1)));
    gender = Gender.fromCode(matches.group(2));
    if (age == null || gender == null) {
      throw ArgumentError('Unrecognized division: "$display"');
    }
  }

  /// Create based on ID string
  ///
  /// String example: 'U5B', combining AgeGroup ID (not cutoff) and
  /// one character for gender
  Division.fromIdString(String display) {
    final matches = _fromString.firstMatch(display);
    if (matches == null) {
      throw ArgumentError('Invalid format for division code: "$display"');
    }
    age = AgeGroup.fromId(int.parse(matches.group(1)));
    gender = Gender.fromCode(matches.group(2));
    if (age == null || gender == null) {
      throw ArgumentError('Unrecognized division: "$display"');
    }
  }

  /// Gender for the division
  Gender gender;

  /// Age group for the division
  AgeGroup age;

  final RegExp _fromString = RegExp(r'U?(\d+)([A-Z])', caseSensitive: false);

  /// Show long displayable name of form 'U10 Girls'
  String getDisplayName() {
    return '$age ${gender.long}';
  }

  /// Show short display name - same used in fromString constructor
  String shortDisplayName() {
    return '$age${gender.short}';
  }
}
