import 'package:meta/meta.dart';

import '../data_config.dart';

/// Class describing a gender
///
/// This is used for classification of teams
class Gender {
  /// Constant constructor.
  ///
  /// Avoid using this, it may disappear if switch to built_value enum-type
  const Gender({
    @required this.short,
    @required this.long,
  });

  /// Create based on single-character code
  factory Gender.fromCode(String code) {
    return GENDERS.singleWhere(
      (gender) => gender.short == code,
      orElse: () => null,
    );
  }

  /// Enumeration of all gender classifications used in app
  // ignore: non_constant_identifier_names
  static Set<Gender> get GENDERS => DataConfig.genders;

  /// Single-character representation of gender
  final String short;

  /// Description of gender
  final String long;
}
