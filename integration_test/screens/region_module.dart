import 'package:flutter_driver_helper/flutter_driver_helper.dart';

class RegionListScreen extends TestScreen {
  TestWidget get view => tWidget('RegionListView');
  TestWidget get home => tWidget('navHome');

  TestWidget roadMap(int regionNum) => tWidget('navRegion$regionNum-RoadMap');
  TestWidget fieldMap(int regionNum) => tWidget('navRegion$regionNum-FieldMap');
}

class StreetMapScreen extends TestScreen {
  TestWidget get view => tWidget('StreetMapView');
  TestWidget get home => tWidget('navHome');
}

class FieldScreen extends TestScreen {
  TestWidget get view => tWidget('FieldView');
  TestWidget get home => tWidget('navHome');
}
