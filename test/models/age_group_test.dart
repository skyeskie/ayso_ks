import 'package:ayso_ks/models/age_group.dart';
import 'package:test/test.dart';

void main() {
  test('create group', () {
    final ag = AgeGroup(code: 1, cutoff: 20);
    expect(ag.code, 1);
    expect(ag.cutoff, 20);
  });

  test('return formatted string', () {
    final ag = AgeGroup(code: 0, cutoff: 42);
    expect(ag.toString(), 'U42');
  });

  group('fromCutoff constructor', () {
    test('error on invalid lookup', () {
      expect(() => AgeGroup.fromCutoff(-10), throwsStateError);
    });

    test('should return a lookup', () {
      final ag = AgeGroup.AGES.first;
      expect(AgeGroup.fromCutoff(ag.cutoff), ag);
    });
  });

  group('configuration', () {
    test('codes are unique', () {
      final Set<int> codes = AgeGroup.AGES.map((e) => e.code).toList().toSet();
      expect(AgeGroup.AGES.length, codes.length);
    });

    test('cutoffs are unique', () {
      final Set<int> vals = AgeGroup.AGES.map((e) => e.cutoff).toList().toSet();
      expect(AgeGroup.AGES.length, vals.length);
    });
  });
}
