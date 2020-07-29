import 'package:ayso_ks/dao/static/week_cache.dart';

import 'week_cache_spec.dart';

void main() {
  weekCacheInterfaceReadSpec(() => WeekCacheStaticDAO());
  weekCacheInterfaceReadonlySpec(() => WeekCacheStaticDAO());
}
