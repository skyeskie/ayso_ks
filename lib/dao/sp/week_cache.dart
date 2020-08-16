import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time/time.dart';

import '../../util/week_calc.dart';
import '../week_cache.dart';

/// Implementation of Week Cache using shared_preferences library
///
/// Suitable for Android and iOS
/// Only week starts is stored
class WeekCacheSpDAO implements WeekCacheDAO {
  /// Create object, initializing the SharedPreferences link
  ///
  /// Set [mockCurWeek] if need to use a specific current week instead
  /// of calculating it based on current time
  WeekCacheSpDAO({int mockCurWeek}) {
    prefsFuture = GetIt.I.getAsync<SharedPreferences>()
      ..then((sp) {
        _prefs = sp;
      });
    if (mockCurWeek != null) {
      _curWeek = mockCurWeek;
      _recalculateAfter = DateTime.now() + 1.days;
    }
  }

  /// Future for obtaining the SharedPreferences handle
  Future<SharedPreferences> prefsFuture;
  SharedPreferences _prefs;

  /// Shared preferences key used for storing week starts
  static const String WEEKS_KEY = 'week_starts';

  int _curWeek;
  DateTime _recalculateAfter;

  @override
  Future<void> clear() {
    _curWeek = null;
    return _prefs.remove(WEEKS_KEY);
  }

  @override
  int getCurrentWeek() {
    if (_curWeek != null &&
        _recalculateAfter != null &&
        DateTime.now().isBefore(_recalculateAfter)) {
      return _curWeek;
    }

    final weeksString = _prefs.getStringList(WEEKS_KEY) ?? [];
    final weekStarts = weeksString.map(DateTime.parse);
    if (weekStarts.isEmpty) return 1;
    _curWeek = calculateCurrentWeek(weekStarts);
    if (_curWeek == weekStarts.length) {
      _recalculateAfter = DateTime.now() + 1.days;
    } else {
      _recalculateAfter = weekStarts.elementAt(_curWeek);
    }
    return _curWeek;
  }

  @override
  int getMaxWeeks() {
    final weeks = _prefs.getStringList(WEEKS_KEY) ?? [];
    return weeks.isEmpty ? 1 : weeks.length;
  }

  @override
  Future init(Iterable<DateTime> starts) {
    final stringStarts = starts.map((dt) => dt.toIso8601String()).toSet();
    return _prefs.setStringList(WEEKS_KEY, stringStarts.toList());
  }

  @override
  bool isInit() {
    return _prefs.containsKey(WEEKS_KEY);
  }
}
