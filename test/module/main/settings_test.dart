import 'package:ayso_ks/module/main/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/test_it.dart';

void main() {
  tearDown(TestIt.clean);

  testWidgets('display', (tester) async {
    TestIt.registerSettings();
    await tester.pumpWidget(MaterialApp(home: SettingsView()));
    expect(find.text('Loading...'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Loading...'), findsNothing);

    final radioFinder = find.byWidgetPredicate(
            (widget) => widget is FormBuilderRadioGroup<int>
    );
    expect(radioFinder, findsOneWidget);
    final form = tester.firstState<FormBuilderState>(find.byType(FormBuilder))
      ..save();
    expect(form.value, containsPair('region', 49));

    expect(find.text('Region 208 (West Wichita)'), findsOneWidget);
    await tester.tap(find.text('Region 208 (West Wichita)'));
    form.save();
    expect(form.value, containsPair('region', 208));
  });
}
