import '../week_cache.dart';

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
