/// Short English display names (1-4 characters) for each month
const List<String> monthsShort = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'June',
  'July',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec',
];

/// DateTime extension for displaying a datetime as "Jan 12, 10:01"
extension MediumDateFormat on DateTime {
  /// Display the date in the format "Jan 12, 10:01"
  ///
  /// The hour will be 12-hour format, but NO am/pm is shown
  /// Length is 11-14 characters long
  String toMediumString() {
    final sb = StringBuffer()
      ..writeAll([
        monthsShort[month - 1],
        ' ',
        day,
        ', ',
        (hour > 12) ? hour - 12 : hour,
        ':',
        if (minute < 10) '0',
        minute,
      ]);
    return sb.toString();
  }
}
