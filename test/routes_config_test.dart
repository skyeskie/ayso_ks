import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sailor/sailor.dart';

import 'mock/test_it.dart';

void main() {
  const testParams = {
    'regionNum': 49,
    'id': '111',
    'week': 2,
    'age': 'U12',
    'gender': 'Girls',
    'interruptedRoute': RouteSettings(
      name: '/',
    ),
  };

  group('navigation initialization', () {
    final nav = TestIt.stubNavigation();
    TestIt.registerAllStatic();

    test('have routes', () {
      expect(nav.allRoutes, isNotEmpty);
    });

    for (final route in nav.allRoutes) {
      final paramConfig = <String, SailorParam>{};
      final paramValues = <String, dynamic>{};
      for (final param in (route.params ?? <SailorParam>[])) {
        paramConfig[param.name] = param;
        paramValues[param.name] = testParams[param.name];
      }
      test('route: ${route.name}', () {
        final widget = route.builder(
          null,
          null,
          ParamMap(route.name, paramConfig, paramValues),
        );
        expect(widget, isA<Widget>());
      });
    }
  });
}
