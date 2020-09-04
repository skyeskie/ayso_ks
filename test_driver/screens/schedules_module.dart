import 'package:flutter_driver/src/driver/driver.dart';
import 'package:flutter_driver_helper/flutter_driver_helper.dart';

class SchedulesMenuScreen extends BaseScreen {
  SchedulesMenuScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('SchedulesMenu');
  DWidget get home => dWidget('navHome');
  DWidget get subheader => dWidget('headerRegionSchedules');

  DWidget get week => dWidget('navCurWeek');
  DWidget get teamSelect => dWidget('navTeamSelect');
  DWidget get search => dWidget('navSearch');
  DWidget get roadMap => dWidget('navRoadMap');
  DWidget get fieldMap => dWidget('navFieldMap');
}

class WeekScheduleScreen extends BaseScreen {
  WeekScheduleScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('WeekScheduleView');
  DWidget get home => dWidget('navHome');

  DWidget get prevWeek => dWidget('navPrevWeek');
  DWidget get nextWeek => dWidget('navNextWeek');
}

class GameDetailScreen extends BaseScreen {
  GameDetailScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('GameDetailView');
  DWidget get home => dWidget('navHome');

  DWidget get roadMap => dWidget('navRoadMap');
  DWidget get fieldMap => dWidget('navFieldMap');
}

class FavoritesListScreen extends BaseScreen {
  FavoritesListScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('FavoritesListView');
  DWidget get home => dWidget('navHome');

  DWidget get findTeam => dWidget('navFindTeam');

  DWidget favoriteTeam(String code) => dWidget('navTeam_$code');
}

class TeamScheduleScreen extends BaseScreen {
  TeamScheduleScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('TeamScheduleView');
  DWidget get home => dWidget('navHome');

  DWidget get favoriteToggle => dWidget('favoriteToggle');
}

class SearchResultsScreen extends BaseScreen {
  SearchResultsScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('SearchResultsView');
  DWidget get home => dWidget('navHome');

  DWidget get prevWeek => dWidget('navPrevWeek');
  DWidget get nextWeek => dWidget('navNextWeek');
}
