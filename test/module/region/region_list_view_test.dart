import 'package:ayso_ks/module/region/region_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('instantiates', (tester) async {
    await tester.pumpWidget(MaterialApp(home: RegionListView()));
    //Not really much; most testing in RegionListViewTile
    expect(find.text('Region 49'), findsOneWidget);
  });
}
