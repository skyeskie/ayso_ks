import 'package:ayso_ks/module/region/region_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sailor/sailor.dart';

import '../mock/test_it.dart';

void main() {
  //TODO: Test with just navBar
  tearDown(TestIt.clean);

  testWidgets('home button - via regions page', (tester) async {
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(home: RegionListView()));
    final homeIcon = find.byIcon(Icons.home);
    expect(homeIcon, findsOneWidget);
    await tester.tap(homeIcon);
    expect(nav.attempts.length, 1);
    final attempt = nav.attempts.first;
    expect(attempt.name, '/');
    expect(attempt.type, NavigationType.pushAndRemoveUntil);
    expect(
      attempt.removeUntilPredicate(
        MaterialPageRoute(builder: (_) => Container()),
      ),
      isA<bool>(),
    );
  });
}
