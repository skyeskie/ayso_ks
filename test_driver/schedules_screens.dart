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
