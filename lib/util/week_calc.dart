/// @param starts - list of Date objects indicating week start
/// Doesn't need to be in-order
///
///@throws ArgumentError if starts doesn't have at least one item
/// @param now (optional) - defaults to getting current time
/// @returns {number} current game week
/// - If before season, constrain to first week
/// - If after season, constrain to last week
int calculateCurrentWeek(Iterable<DateTime> starts, {DateTime now}) {
  if (starts == null || starts.isEmpty) {
    throw ArgumentError('Need at least 1 date object in starts');
  }

  now ??= DateTime.now();
  if (now.isBefore(starts.first)) {
    return 1;
  }

  var weekNum = 0;
  for (final weekStart in starts) {
    if (now.isBefore(weekStart)) return weekNum;
    weekNum++;
  }
  return weekNum;
}
