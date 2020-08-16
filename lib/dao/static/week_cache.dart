import '../week_cache.dart';

/// Static, read-only implementation of Week Cache
///
/// Fixes current week to 2 and max weeks to 4 (in-line with data.dart)
class WeekCacheStaticDAO implements WeekCacheDAO {
  @override
  Future<void> clear() {
    return Future.value();
  }

  @override
  int getCurrentWeek() {
    return 2;
  }

  @override
  int getMaxWeeks() {
    return 4;
  }

  @override
  Future init(Iterable<DateTime> starts) {
    return Future.value();
  }

  @override
  bool isInit() {
    return true;
  }
}
