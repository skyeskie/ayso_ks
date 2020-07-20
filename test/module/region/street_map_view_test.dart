import 'package:ayso_ks/module/region/street_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('minimal', (tester) async {
    await tester.pumpWidget(MaterialApp(home: StreetMapView(49)));
    expect(find.text('Region 49'), findsOneWidget);
  });
}
