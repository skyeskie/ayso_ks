import 'package:sailor/sailor.dart';

import 'module/main/main_module.dart';
import 'module/region/region_module.dart';
import 'module/schedules/schedules_module.dart';
import 'module/search/search_module.dart';

// ignore: avoid_classes_with_only_static_members
class Routing {
  static final Sailor sailor = Sailor();

  static void createRoutes() {
    sailor
      ..addRoutes(mainModuleRoutes)
      ..addRoutes(regionModuleRoutes)
      ..addRoutes(scheduleModuleRoutes)
      ..addRoutes(searchModuleRoutes);
  }
}
