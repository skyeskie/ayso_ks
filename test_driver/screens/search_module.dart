import 'package:flutter_driver/src/driver/driver.dart';
import 'package:flutter_driver_helper/flutter_driver_helper.dart';

class SearchScreen extends BaseScreen {
  SearchScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('SearchView');
  DWidget get home => dWidget('navHome');

  DWidget get regionDropdown => dWidget('regionDropdown');
  DWidget regionOption(int regionNum) => dWidget('regionDropdown_$regionNum');
  DWidget get ageDropdown => dWidget('ageDropdown');
  DWidget ageOption(int cutoff) => dWidget('ageDropdown_$cutoff');
  DWidget get genderDropdown => dWidget('genderDropdown');
  DWidget genderOption(String short) => dWidget('genderDropdown_$short');

  DWidget get submit => dWidget('formSubmit');
}

class TeamSelectScreen extends BaseScreen {
  TeamSelectScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('TeamSelectView');
  DWidget get home => dWidget('navHome');

  DWidget regionOption(int regionNum) => dWidget('regionChip_$regionNum');
  DWidget ageGroupOption(int cutoff) => dWidget('ageChip_$cutoff');
  DWidget genderOption(String short) => dWidget('genderChip_$short');

  DWidget get results => dWidget('scrollResultTeams');

  DScrollItem resultTeam(String code) =>
      dScrollItem('teamResult_$code', results);
}
