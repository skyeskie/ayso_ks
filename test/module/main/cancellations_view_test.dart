import 'package:ayso_ks/module/main/cancellations_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('display', (tester) async {
    await tester.pumpWidget(MaterialApp(home: CancellationsView()));
    expect(find.text('Cancellations'), findsOneWidget);

    //Using web view, so can't really test more
  });
}
