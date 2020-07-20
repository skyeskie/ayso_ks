import 'package:ayso_ks/dao/mem/settings.dart';
import 'package:ayso_ks/dao/settings.dart';
import 'package:ayso_ks/module/main/app.dart';
import 'package:ayso_ks/module/main/data_controller.dart';
import 'package:ayso_ks/module/main/home_view.dart';
import 'package:ayso_ks/module/main/init_view.dart';
import 'package:ayso_ks/routes_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sailor/sailor.dart';

import '../../mock/test_it.dart';

void main() {
  tearDown(TestIt.clean);

  testWidgets('sanity', (tester) async {
    // mock returns a simple Container() in the routing function
    TestIt.stubNavigation();
    TestIt.registerSettings();
    await tester.pumpWidget(AysoApp());
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('default routes to home', (tester) async {
    TestIt.registerSettings();
    Routing.sailor = Sailor();
    Routing.createRoutes();
    await tester.pumpWidget(AysoApp());

    expect(find.byType(HomeView), findsOneWidget);
  });

  testWidgets('uninitialized routes to init', (tester) async {
    TestIt.registerAllStatic();
    TestIt.I.unregister<SettingsDAO>();
    TestIt.I.registerSingleton<SettingsDAO>(SettingsInMemoryDAO());
    TestIt.I.registerSingleton<DataController>(DataController());
    Routing.sailor = Sailor();
    Routing.createRoutes();
    await tester.pumpWidget(AysoApp());

    expect(find.byType(InitView), findsOneWidget);
  });
}
