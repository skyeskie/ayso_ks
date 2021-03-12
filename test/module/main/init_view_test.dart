import 'dart:async';

import 'package:ayso_ks/dao/settings.dart';
import 'package:ayso_ks/module/main/data_controller.dart';
import 'package:ayso_ks/module/main/init_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:mockito/mockito.dart';

import '../../mock/test_it.dart';

class DataControllerMock extends Mock implements DataController {}

void main() {
  setUp(TestIt.registerAllStatic);
  tearDown(TestIt.clean);

  testWidgets('not init, data loads first', (tester) async {
    TestIt.registerSettingsMutable();
    TestIt.I.registerSingleton(DataController());
//    final nav = TestIt.stubNavigation();
    await tester.pumpWidget(MaterialApp(
      home: InitView(
        interruptedRoute: RouteSettings(
          name: '/',
        ),
      ),
    ));
    expect(tester.getSubmitButton().onPressed, isNull);

    expect(find.text('Loading Game Data'), findsOneWidget);
    expect(find.text('Setup App'), findsOneWidget);

    //Backend load
    await tester.pumpAndSettle();
    expect(tester.getSubmitButton().onPressed, isNull);

    //Fill in form
    expect(find.text('Select your home region...'), findsOneWidget);
    final dropdown = tester.widget<FormBuilderDropdown>(
      find.byWidgetPredicate((widget) => widget is FormBuilderDropdown<int>),
    );
    //Tap doesn't seem to work well with dropdown,
    //so directly access the change handler
    dropdown.onChanged(49);
    await tester.pumpAndSettle();
    expect(tester.getSubmitButton().onPressed, isNotNull);
    expect(TestIt.I.get<SettingsDAO>().getRegionNumber(), completion(49));

    //Press button
//    await tester.tap(find.text('Finish'));
//    expect(nav.attempts, hasLength(1));
//    expect(nav.attempts.first.name, '/');
  });

  testWidgets('not init, form completed first', (tester) async {
    print('Setup mocks');
    final dataControl = DataControllerMock();
    when(dataControl.isAppConfigured).thenReturn(false);
    final finishLoad = Completer();
    when(dataControl.refreshData()).thenAnswer((_) => finishLoad.future);
    when(dataControl.configureRegion(any)).thenAnswer((_) => Future.value());
    TestIt.registerSettingsMutable();
    TestIt.I.registerSingleton<DataController>(dataControl);
    final nav = TestIt.stubNavigation();
    print('Create view');
    await tester.pumpWidget(MaterialApp(
      home: InitView(
        interruptedRoute: RouteSettings(
          name: '/',
        ),
      ),
    ));
    expect(tester.getSubmitButton().onPressed, isNull);

    print('Set region from form dropdown');
    expect(find.text('Select your home region...'), findsOneWidget);
    final dropdown = tester.widget<FormBuilderDropdown>(
      find.byWidgetPredicate((widget) => widget is FormBuilderDropdown<int>),
    );
    //Tap doesn't seem to work well with dropdown,
    //so directly access the change handler
    dropdown.onChanged(49);
    await tester.pump();
    expect(tester.getSubmitButton().onPressed, isNull);

    print('Load data');
    finishLoad.complete();
    await tester.pumpAndSettle();
    expect(tester.getSubmitButton().onPressed, isNotNull);
//    await tester.tap(find.text('Finish'));
//    expect(nav.attempts, hasLength(1));
//    expect(nav.attempts.first.name, '/region');
  }, skip: true); // Router nav triggers, which we're avoiding for unit tests

  testWidgets('already init', (tester) async {
    TestIt.I.registerSingleton(DataController());
    await tester.pumpWidget(MaterialApp(
      home: InitView(
        interruptedRoute: RouteSettings(
          name: '/',
        ),
      ),
    ));

    expect(find.text('Loading Game Data'), findsOneWidget);
    expect(find.text('Setup App'), findsNothing);

    //Don't actually navigate.
    //The guard hack means it'd require a complicated mock
    //Once have actual Sailor RouteGuard that can redirect route, revisit
  });
}

extension SubmitButtonGetter on WidgetTester {
  GFButton getSubmitButton() => widget<GFButton>(find.byType(GFButton));
}
