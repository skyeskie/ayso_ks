import 'package:sailor/sailor.dart';

import 'search_view.dart';
import 'team_select_view.dart';

/// Navigation/Routing configuration for the Search module
final List<SailorRoute> searchModuleRoutes = <SailorRoute>[
  SailorRoute(
    name: '/search',
    builder: (ctx, args, params) => SearchView(),
  ),
  SailorRoute(
    name: '/search/teams',
    builder: (ctx, args, params) => TeamSelectView(),
  ),
];
