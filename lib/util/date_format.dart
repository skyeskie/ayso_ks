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

extension MediumDateFormat on DateTime {
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
