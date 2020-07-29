import 'package:ayso_ks/dao/sp/week_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time/time.dart';

import '../mock/test_data.dart';
import '../mock/test_it.dart';
import 'week_cache_spec.dart';

void main() {
  final testWeeks = TestData.weeks.map((dt) => dt.toIso8601String()).toList();
  SharedPreferences.setMockInitialValues({});

  setUp(() async {
    final prefs = await TestIt.I.getAsync<SharedPreferences>();
    return prefs.setStringList(WeekCacheSpDAO.WEEKS_KEY, testWeeks);
  });

  TestIt.I.registerSingletonAsync<SharedPreferences>(
    SharedPreferences.getInstance,
  );

  weekCacheInterfaceReadSpec(() => WeekCacheSpDAO(mockCurWeek: 2));
  weekCacheInterfaceWriteSpec(() => WeekCacheSpDAO(mockCurWeek: 2));

  test('calculate week starts after final', () async {
    final dao = WeekCacheSpDAO();
    await TestIt.I.getAsync<SharedPreferences>();
    expect(dao.getCurrentWeek(), testWeeks.length);
  });

  test('calculate week starts in middle', () async {
    final dao = WeekCacheSpDAO();
    final prefs = await TestIt.I.getAsync<SharedPreferences>();
    final now = DateTime.now();
    final starts = [
      now - 2.weeks,
      now - 1.weeks,
      now - 1.minutes,
      now + 1.weeks,
      now + 2.weeks,
    ];
    final startsString = starts.map((e) => e.toIso8601String()).toList();
    await prefs.setStringList(WeekCacheSpDAO.WEEKS_KEY, startsString);
    expect(dao.getCurrentWeek(), 3);
  });
}
