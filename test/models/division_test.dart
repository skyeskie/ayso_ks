@Tags(['model'])

import 'package:ayso_ks/models/age_group.dart';
import 'package:ayso_ks/models/division.dart';
import 'package:ayso_ks/models/gender.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('create object', () {
    final gender = Gender.fromCode('B');
    final age = AgeGroup.fromCutoff(10);
    final divis = Division(gender: gender, age: age);
    expect(divis.gender, gender);
    expect(divis.age, age);
  });

  group('create fromString', () {
    test('create object', () {
      final divis = Division.fromString('U10B');
      expect(divis.getDisplayName(), 'U10 Boys');

      final divis2 = Division.fromString('U12G');
      expect(divis2.getDisplayName(), 'U12 Girls');
    });

    test('create without "U" prefix', () {
      final divis = Division.fromString('6C');
      expect(divis.getDisplayName(), 'U6 Coed');
    });

    test('error on invalid age portion', () {
      expect(() => Division.fromString('U42B'), throwsArgumentError);
    });

    test('error on invalid gender portion', () {
      expect(() => Division.fromString('U10Z'), throwsArgumentError);
    });

    test('error on invalid format', () {
      expect(() => Division.fromString('B10'), throwsArgumentError);
    });
  });

  group('create fromIdString', () {
    test('create object', () {
      final divis = Division.fromIdString('5B');
      expect(divis.getDisplayName(), 'U10 Boys');

      final divis2 = Division.fromIdString('4G');
      expect(divis2.getDisplayName(), 'U12 Girls');
    });

    test('create without "U" prefix', () {
      final divis = Division.fromIdString('7C');
      expect(divis.getDisplayName(), 'U6 Coed');
    });

    test('error on invalid age portion', () {
      expect(() => Division.fromIdString('9B'), throwsArgumentError);
    });

    test('error on invalid gender portion', () {
      expect(() => Division.fromIdString('5Z'), throwsArgumentError);
    });

    test('error on invalid format', () {
      expect(() => Division.fromIdString('B5'), throwsArgumentError);
    });
  });

  group('display name', () {
    final divisU10B =
        Division(gender: Gender.fromCode('B'), age: AgeGroup.fromCutoff(10));
    final divisU12G = Division.fromString('U12G');
    final divisU5C = Division.fromString('U5C');

    test('long display name', () {
      expect(divisU5C.getDisplayName(), 'U5 Coed');
      expect(divisU10B.getDisplayName(), 'U10 Boys');
      expect(divisU12G.getDisplayName(), 'U12 Girls');
    });

    test('short display name', () {
      expect(divisU5C.shortDisplayName(), 'U5C');
      expect(divisU10B.shortDisplayName(), 'U10B');
      expect(divisU12G.shortDisplayName(), 'U12G');
    });
  });
}
