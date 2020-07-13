import 'package:flutter_modular/flutter_modular.dart';

import 'favorites_list_view.dart';
import 'game_detail_view.dart';
import 'schedules_menu_view.dart';
import 'search_results_view.dart';
import 'team_schedule.dart';
import 'week_schedule_view.dart';

class SchedulesModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', child: (ctx, args) => SchedulesMenuView()),
        Router('/favorites', child: (ctx, args) => FavoritesListView()),
        Router('/game/:id',
            child: (ctx, args) => GameDetailView(id: args.params['id'])),
        Router(
          '/search',
          child: (ctx, args) => SearchResultsView(
            week: args.data['week'],
            ageGroup: args.data['age'],
            gender: args.data['gender'],
            regionNum: args.data['region'],
          ),
        ),
        Router(
          '/team/:id',
          child: (ctx, args) => TeamScheduleView(
            teamId: args.params['id'],
          ),
        ),
        Router('/week', child: (ctx, args) => WeekScheduleView()),
        Router(
          '/week/:num',
          child: (ctx, args) => WeekScheduleView(
            week: int.parse(args.params['num'], radix: 10),
          ),
        ),
      ];
}
