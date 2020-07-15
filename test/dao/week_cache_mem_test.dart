import 'package:ayso_ks/dao/mem/week_cache.dart';

import '../mock/test_data.dart';
import 'week_cache_spec.dart';

void main() {
  weekCacheInterfaceReadSpec(
    () => WeekCacheInMemoryDAO(initStarts: TestData.weeks, mockCurWeek: true),
  );
  weekCacheInterfaceWriteSpec(
    () => WeekCacheInMemoryDAO(initStarts: TestData.weeks, mockCurWeek: true),
  );
}
