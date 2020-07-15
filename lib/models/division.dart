import 'package:meta/meta.dart';

import 'age_group.dart';
import 'gender.dart';

class Division {
  Division({
    @required this.gender,
    @required this.age,
  });

  Division.fromString(String display) {
    final matches = _fromString.firstMatch(display);
    if (matches == null) {
      throw RangeError('Invalid format for division code: "$display"');
    }
    age = AgeGroup.fromCutoff(int.parse(matches.group(1)));
    gender = Gender.fromCode(matches.group(2));
  }

  Gender gender;
  AgeGroup age;

  final RegExp _fromString = RegExp(r'U?(\d+)([A-Z])', caseSensitive: false);

  String getDisplayName() {
    return '$age ${gender.long}';
  }

  String shortDisplayName() {
    return '$age${gender.short}';
  }
}
