import 'package:ayso_ks/module/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';
import '../../util/form_builder_finder.dart';

void main() {
  setUp(TestIt.registerWeekCache);
  tearDown(TestIt.clean);

  testWidgets('labels present', (tester) async {
    await tester.pumpWidget(MaterialApp(home: SearchView()));
    expect(find.text('Week'), findsOneWidget);
    expect(find.text('Region'), findsOneWidget);
    expect(find.text('Division'), findsOneWidget);
    expect(find.text('Age'), findsOneWidget);
    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('Go'), findsOneWidget);
  });

  testWidgets('form fields present', (tester) async {
    await tester.pumpWidget(MaterialApp(home: SearchView()));
    expect(find.formBuilderAttribute('week'), findsOneWidget);
    final week = tester.widget<FormBuilderSlider>(
      find.formBuilderAttribute('week'),
    );
    expect(week.max, 4);
    expect(week.divisions, 3);
    expect(find.formBuilderAttribute('regionNum'), findsOneWidget);
    expect(find.formBuilderAttribute('age'), findsOneWidget);
    expect(find.formBuilderAttribute('gender'), findsOneWidget);
  });

  testWidgets('form submission', (tester) async {
    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(home: SearchView()));
//    await tester.tap(find.text('Region'));
//    await tester.pump();
//    await tester.tap(find.text('49 - Stryker').first);
//    await tester.pump();
//    await tester.tap(find.text('Age'));
//    await tester.pump();
//    await tester.tap(find.text('U10').first);
//    await tester.pump();
//    await tester.tap(find.text('Gender'));
//    await tester.pump();
//    await tester.tap(find.text('Girls').first);
//    await tester.pump();

    await tester.tap(find.text('Go'));
    expect(nav.attempts, hasLength(1));
    final navAttempt = nav.attempts.first;
    expect(navAttempt.name, '/schedules/filtered');
    expect(navAttempt.params['week'], 1);
//    expect(navAttempt.params['region'], 49);
//    expect(navAttempt.params['age'], 'U12');
//    expect(navAttempt.params['gender'], 'Girls');
  });
}
