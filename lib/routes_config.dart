import 'package:sailor/sailor.dart';

import 'module/main/main_module.dart';
import 'module/region/region_module.dart';
import 'module/schedules/schedules_module.dart';
import 'module/search/search_module.dart';

// ignore: avoid_classes_with_only_static_members
/// Main routing configuration
class Routing {
  /// Static access to the [Sailor] singleton
  static Sailor sailor = Sailor();

  /// Register all routes with Sailor
  ///
  /// Note: these are broken up into different modules
  static void createRoutes() {
    sailor
      ..addRoutes(mainModuleRoutes)
      ..addRoutes(regionModuleRoutes)
      ..addRoutes(scheduleModuleRoutes)
      ..addRoutes(searchModuleRoutes);
  }
}
