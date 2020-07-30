import 'package:sailor/sailor.dart';

import 'field_view.dart';
import 'region_list_view.dart';
import 'street_map_view.dart';

/// Navigation/routing configuration for the Region module
final List<SailorRoute> regionModuleRoutes = <SailorRoute>[
  SailorRoute(
    name: '/region',
    builder: (ctx, args, params) => RegionListView(),
  ),
  SailorRoute(
    name: '/region/list',
    builder: (ctx, args, params) => RegionListView(),
  ),
  SailorRoute(
    name: '/region/field',
    params: [
      SailorParam<int>(name: 'regionNum', isRequired: true),
    ],
    builder: (ctx, args, params) {
      return FieldView(params.param<int>('regionNum'));
    },
  ),
  SailorRoute(
    name: '/region/map',
    params: [
      SailorParam<int>(name: 'regionNum', isRequired: true),
    ],
    builder: (ctx, args, params) {
      return StreetMapView(params.param<int>('regionNum'));
    },
  ),
];
