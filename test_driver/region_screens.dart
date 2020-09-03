import 'package:flutter_driver/src/driver/driver.dart';
import 'package:flutter_driver_helper/flutter_driver_helper.dart';

class RegionListScreen extends BaseScreen {
  RegionListScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('RegionListView');
  DWidget get home => dWidget('navHome');

  DWidget roadMap(int regionNum) => dWidget('navRegion$regionNum-RoadMap');
  DWidget fieldMap(int regionNum) => dWidget('navRegion$regionNum-FieldMap');
}

class StreetMapScreen extends BaseScreen {
  StreetMapScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('StreetMapView');
  DWidget get home => dWidget('navHome');
}

class FieldScreen extends BaseScreen {
  FieldScreen(FlutterDriver driver) : super(driver);

  DWidget get view => dWidget('FieldView');
  DWidget get home => dWidget('navHome');
}
