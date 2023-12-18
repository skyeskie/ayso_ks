import 'package:time/time.dart';

/// Extensions on [DateTime] to assist in calculating week starts
extension WeekStartCalc on DateTime {
  /// Returns the date portion, with time values zeroed out
  DateTime dateOnly() {
    return DateTime(year, month, day);
  }

  /// Changes the day so that it is the closest Wednesday, going backwards
  ///
  /// When called on a Wednesday, returns an exact copy
  DateTime previousWednesday() {
    var diff = weekday - DateTime.wednesday;
    if (diff < 0) diff += 7;
    return this - diff.days;
  }
}
