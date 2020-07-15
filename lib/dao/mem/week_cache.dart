import 'dart:collection';

import '../../util/week_calc.dart';
import '../week_cache.dart';

class WeekCacheInMemoryDAO implements WeekCacheDAO {
  WeekCacheInMemoryDAO({
    Iterable<DateTime> initStarts,
    bool mockCurWeek = false,
  }) {
    if (initStarts != null) {
      init(initStarts, mockCurWeek: mockCurWeek);
    }
  }

  List<DateTime> _weekStarts = [];
  int _curWeek;

  @override
  Future<void> clear() {
    if (_curWeek != null) _curWeek = 1;
    _weekStarts.clear();
    return Future.value();
  }

  @override
  int getCurrentWeek() {
    return _curWeek ?? calculateCurrentWeek(_weekStarts);
  }

  @override
  int getMaxWeeks() {
    return _weekStarts.isEmpty ? 1 : _weekStarts.length;
  }

  @override
  Future init(Iterable<DateTime> starts, {bool mockCurWeek = false}) {
    final set = SplayTreeSet<DateTime>.from(starts);
    _weekStarts = set.toList();
    if (mockCurWeek) {
      _curWeek = (_weekStarts.length > 2) ? 2 : 1;
    }
    return Future.value();
  }

  @override
  bool isInit() {
    return (_weekStarts != null && _weekStarts.length > 1);
  }
}
