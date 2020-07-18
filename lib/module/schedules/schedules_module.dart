import 'package:sailor/sailor.dart';

import 'favorites_list_view.dart';
import 'game_detail_view.dart';
import 'schedules_menu_view.dart';
import 'search_results_view.dart';
import 'team_schedule.dart';
import 'week_schedule_view.dart';

final List<SailorRoute> scheduleModuleRoutes = <SailorRoute>[
  SailorRoute(
    name: '/schedules',
    params: [
      SailorParam<int>(name: 'regionNum', isRequired: true),
    ],
    builder: (ctx, args, params) => SchedulesMenuView(
      params.param('regionNum'),
    ),
  ),
  SailorRoute(
    name: '/schedules/favorites',
    builder: (ctx, args, params) => FavoritesListView(),
  ),
  SailorRoute(
    name: '/schedules/game',
    params: [
      SailorParam<String>(name: 'id', isRequired: true),
    ],
    builder: (ctx, args, params) => GameDetailView(id: params.param('id')),
  ),
  SailorRoute(
    name: '/schedules/filtered',
    params: [
      SailorParam<int>(name: 'week'),
      SailorParam<String>(name: 'age'),
      SailorParam<String>(name: 'gender'),
      SailorParam<int>(name: 'regionNum'),
    ],
    builder: (ctx, args, params) => SearchResultsView(
      week: params.param<int>('week'),
      ageGroup: params.param<String>('age'),
      gender: params.param<String>('gender'),
      regionNum: params.param<int>('regionNum'),
    ),
  ),
  SailorRoute(
    name: '/schedules/team',
    params: [
      SailorParam<String>(name: 'id', isRequired: true),
    ],
    builder: (ctx, args, params) => TeamScheduleView(
      teamId: params.param<String>('id'),
    ),
  ),
  //TODO: Combine two week routes once null params options fixed
  // ( https://github.com/gurleensethi/sailor/pull/44 )
  SailorRoute(
    name: '/schedules/week',
    params: [
      SailorParam<int>(name: 'weekNum'),
    ],
    builder: (ctx, args, params) => WeekScheduleView(
      week: params?.param<int>('weekNum'),
    ),
  ),
  SailorRoute(
    name: '/schedules/week_current',
    builder: (ctx, args, params) => WeekScheduleView(),
  ),
];
