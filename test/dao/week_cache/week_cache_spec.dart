import 'package:ayso_ks/dao/week_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_data.dart';

typedef WeekCacheDaoGenerator = WeekCacheDAO Function();

void weekCacheInterfaceReadSpec(WeekCacheDaoGenerator initWeekCache) {
  WeekCacheDAO dao;

  group('(WeekCacheDAO) - Read', () {
    setUp(() {
      dao = initWeekCache();
    });

    test('current week', () {
      expect(dao.getCurrentWeek(), 2);
    });

    test('max weeks', () {
      expect(dao.getMaxWeeks(), 4);
    });

    test('tells init status', () {
      expect(dao.isInit(), isTrue);
    });
  });
}

void weekCacheInterfaceWriteSpec(WeekCacheDaoGenerator initWeekCache) {
  WeekCacheDAO dao;

  group('(WeekCacheDAO) - Write', () {
    setUp(() {
      dao = initWeekCache();
    });

    test('resets to current 1 and max 1 on clear', () async {
      await dao.clear();
      expect(dao.getCurrentWeek(), 1);
      expect(dao.getMaxWeeks(), 1);
    });

    test('not initialized after clear', () async {
      await dao.clear();
      expect(dao.isInit(), isFalse);
    });

    test('init removes duplicates', () async {
      await dao.init([
        DateTime.parse('2020-01-01'),
        DateTime.parse('2020-01-01'),
        DateTime.parse('2020-01-07'),
        DateTime.parse('2020-01-07'),
        DateTime.parse('2020-01-07'),
        DateTime.parse('2020-01-15'),
        DateTime.parse('2020-01-22'),
        DateTime.parse('2020-01-22'),
      ]);
      expect(dao.getMaxWeeks(), 4);
    });

    test('init handles unsorted starts', () async {
      await dao.init([
        DateTime.parse('2020-01-01'),
        DateTime.parse('2020-03-07'),
        DateTime.parse('2020-01-07'),
        DateTime.parse('2020-01-22'),
        DateTime.parse('2020-03-07'),
        DateTime.parse('2020-02-07'),
        DateTime.parse('2020-01-15'),
        DateTime.parse('2020-01-22'),
        DateTime.parse('2020-01-01'),
      ]);
      expect(dao.getMaxWeeks(), 6);
    });
  });
}

void weekCacheInterfaceReadonlySpec(WeekCacheDaoGenerator initWeekCache) {
  WeekCacheDAO dao;

  group('(WeekCacheDAO) - Readonly', () {
    setUp(() {
      dao = initWeekCache();
    });

    test('clear is no-op', () async {
      await dao.clear();
      expect(dao.getMaxWeeks(), 4);
      expect(dao.getCurrentWeek(), 2);
    });

    test('is still initialized after clear', () async {
      await dao.clear();
      expect(dao.isInit(), isTrue);
    });

    test('init is no-op', () async {
      await dao.init([TestData.weeks.first]);
      expect(dao.getMaxWeeks(), 4);
    });
  });
}
