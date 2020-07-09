abstract class WeekCacheDAO {
  /// Get the number of weeks in a season
  int getMaxWeeks();

  /// Returns the current week, as determined by game days
  ///
  /// Week is determined by which week starts the game is between
  /// This should always be in the range `[1,maxWeeks]`
  int getCurrentWeek();

  /// Clears underlying data
  Future<void> clear();

  bool isInit();

  /// Initializes the cache
  Future init(Iterable<DateTime> starts);
}

///
/// @param starts - list of Date objects indicating week start. Doesn't need to be in-order
/// @throws RangeError if starts doesn't have at least one item
/// @param now (optional) - defaults to getting current time
/// @returns {number} current game week
/// - If before season, constrain to first week
/// - If after season, constrain to last week
int calculateCurrentWeek(Iterable<DateTime> starts, {DateTime now}) {
  if (starts == null || starts.isEmpty) {
    throw new RangeError('Need at least 1 date object in starts');
  }

  if (now == null) now = DateTime.now();
  if (now.isBefore(starts.first)) {
    return 1;
  }

  int weekNum = 0;
  for (var weekStart in starts) {
    if (now.isBefore(weekStart)) return weekNum;
    weekNum++;
  }
  return weekNum;
}
