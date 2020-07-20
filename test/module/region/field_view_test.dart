import 'package:ayso_ks/module/region/field_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('minimal', (tester) async {
    await tester.pumpWidget(MaterialApp(home: FieldView(49)));
    expect(find.text('Region 49 Fields'), findsOneWidget);
    //TODO: Do a test of the SVG maps in ALL regions so they render
  });
}
