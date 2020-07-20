import 'package:ayso_ks/models/region.dart';
import 'package:ayso_ks/module/region/region_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  testWidgets('navigation', (tester) async {
    final nav = TestIt.stubNavigation();
    final region = Region.fromNumber(49);
    await tester.pumpWidget(MaterialApp(home: RegionInfoTile(region: region)));
    expect(find.text('Region ${region.number}'), findsOneWidget);
    expect(find.text(region.name), findsOneWidget);

    await tester.tap(find.text('Directions'));
    expect(nav.attempts.length, 1);
    var navAttempt = nav.attempts.first;
    expect(navAttempt.name, '/region/map');
    expect(navAttempt.params['regionNum'], region.number);
    nav.attempts.clear();

    await tester.tap(find.text('Field Map'));
    expect(nav.attempts.length, 1);
    navAttempt = nav.attempts.first;
    expect(navAttempt.name, '/region/field');
    expect(navAttempt.params['regionNum'], region.number);
  });
}
