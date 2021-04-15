import 'package:flutter_driver_helper/flutter_driver_helper.dart';

class SchedulesMenuScreen extends TestScreen {
  TestWidget get view => tWidget('SchedulesMenu');
  TestWidget get home => tWidget('navHome');
  TestWidget get subheader => tWidget('headerRegionSchedules');

  TestWidget get week => tWidget('navCurWeek');
  TestWidget get teamSelect => tWidget('navTeamSelect');
  TestWidget get search => tWidget('navSearch');
  TestWidget get roadMap => tWidget('navRoadMap');
  TestWidget get fieldMap => tWidget('navFieldMap');
}

class WeekScheduleScreen extends TestScreen {
  TestWidget get view => tWidget('WeekScheduleView');
  TestWidget get home => tWidget('navHome');

  TestWidget get prevWeek => tWidget('navPrevWeek');
  TestWidget get nextWeek => tWidget('navNextWeek');
}

class GameDetailScreen extends TestScreen {
  TestWidget get view => tWidget('GameDetailView');
  TestWidget get home => tWidget('navHome');

  TestWidget get roadMap => tWidget('navRoadMap');
  TestWidget get fieldMap => tWidget('navFieldMap');
}

class FavoritesListScreen extends TestScreen {
  TestWidget get view => tWidget('FavoritesListView');
  TestWidget get home => tWidget('navHome');

  TestWidget get findTeam => tWidget('navFindTeam');

  TestWidget favoriteTeam(String code) => tWidget('navTeam_$code');
}

class TeamScheduleScreen extends TestScreen {
  TestWidget get view => tWidget('TeamScheduleView');
  TestWidget get home => tWidget('navHome');

  TestWidget get favoriteToggle => tWidget('favoriteToggle');
}

class SearchResultsScreen extends TestScreen {
  TestWidget get view => tWidget('SearchResultsView');
  TestWidget get home => tWidget('navHome');

  TestWidget get prevWeek => tWidget('navPrevWeek');
  TestWidget get nextWeek => tWidget('navNextWeek');
}
