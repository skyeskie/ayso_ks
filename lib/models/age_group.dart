import 'package:meta/meta.dart';

class AgeGroup {
  final int code;
  final int cutoff;

  // ignore: non_constant_identifier_names
  static const Set<AgeGroup> AGES = {
    AgeGroup(code: 1, cutoff: 19),
    AgeGroup(code: 2, cutoff: 16),
    AgeGroup(code: 3, cutoff: 14),
    AgeGroup(code: 4, cutoff: 12),
    AgeGroup(code: 5, cutoff: 10),
    AgeGroup(code: 6, cutoff: 8),
    AgeGroup(code: 7, cutoff: 6),
    AgeGroup(code: 8, cutoff: 5),
  };

  const AgeGroup({
    @required this.code,
    @required this.cutoff,
  });

  factory AgeGroup.fromCutoff(int cutoff) {
    return AGES.singleWhere((ag) => ag.cutoff == cutoff);
  }

  @override
  String toString() {
    return 'U$cutoff';
  }
}
