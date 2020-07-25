@Tags(['model'])

import 'package:ayso_ks/models/gender.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('constructor', () {
    final g = Gender(long: 'LONG', short: 'short');
    expect(g.long, 'LONG');
    expect(g.short, 'short');
  });

  test('fromCode', () {
    final g = Gender.fromCode('G');
    expect(g.short, 'G');
    expect(g.long, 'Girls');
  });

  test('null in fromCode on unknown code', () {
    expect(Gender.fromCode('Z'), isNull);
  });

  test('configured genders have short length 1', () {
    for (final gender in Gender.GENDERS) {
      expect(gender.short.length, 1);
    }
  });
}
