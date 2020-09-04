import 'package:meta/meta.dart';

import '../data_config.dart';

/// Class describing an age grouping
class AgeGroup {
  /// Constant constructor.
  ///
  /// Avoid using this, it may disappear if switch to built_value enum-type
  const AgeGroup({
    @required this.code,
    @required this.cutoff,
  });

  /// Create based on age cutoff
  factory AgeGroup.fromCutoff(int cutoff) {
    return AGES.singleWhere((ag) => ag.cutoff == cutoff, orElse: () => null);
  }

  /// Create based on numeric ID
  factory AgeGroup.fromId(int id) {
    return AGES.singleWhere((ag) => ag.code == id, orElse: () => null);
  }

  /// Numeric ID used on aysoks.org
  ///
  /// No inherent property, but is used for some regions in constructing
  /// Team IDs by providing a single-digit ID
  final int code;

  /// Age cutoff for the division
  ///
  /// This is commonly expressed 'U12' for under-12
  final int cutoff;

  //TODO: Make Enum-like
  //https://dart-lang.github.io/linter/lints/exhaustive_cases.html
  /// Enumeration of all age groups used in app
  // ignore: non_constant_identifier_names
  static Set<AgeGroup> get AGES => DataConfig.ages;

  /// Show a displayable string
  ///
  /// String is like U10, meaning under-10
  @override
  String toString() {
    return 'U$cutoff';
  }
}
