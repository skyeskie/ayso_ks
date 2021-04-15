import 'package:flutter_driver_helper/flutter_driver_helper.dart';
import 'package:flutter_driver_helper/flutter_driver_helper_legacy.dart';

class SearchScreen extends TestScreen {
  TestWidget get view => tWidget('SearchView');
  TestWidget get home => tWidget('navHome');

  TestWidget get regionDropdown => tWidget('regionDropdown');
  TestWidget regionOption(int regionNum) =>
      tWidget('regionDropdown_$regionNum');
  TestWidget get ageDropdown => tWidget('ageDropdown');
  TestWidget ageOption(int cutoff) => tWidget('ageDropdown_$cutoff');
  TestWidget get genderDropdown => tWidget('genderDropdown');
  TestWidget genderOption(String short) => tWidget('genderDropdown_$short');

  TestWidget get submit => tWidget('formSubmit');
}

class TeamSelectScreen extends TestScreen {
  TestWidget get view => tWidget('TeamSelectView');
  TestWidget get home => tWidget('navHome');

  TestWidget regionOption(int regionNum) => tWidget('regionChip_$regionNum');
  TestWidget ageGroupOption(int cutoff) => tWidget('ageChip_$cutoff');
  TestWidget genderOption(String short) => tWidget('genderChip_$short');

  TestWidget get results => tWidget('scrollResultTeams');

  TestWidget resultTeam(String code) => tWidget('teamResult_$code');
}
