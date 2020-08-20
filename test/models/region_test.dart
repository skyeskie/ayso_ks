@Tags(['model'])

import 'package:ayso_ks/models/region.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('constructs', () {
    const r = Region(
      id: 10,
      number: 100,
      name: 'name',
      fieldMap: 'map',
      streetMap: 'road',
      lat: -10.5,
      lon: -20.5,
    );
    expect(r.id, 10);
    expect(r.number, 100);
    expect(r.name, 'name');
    expect(r.fieldMap, 'map');
    expect(r.streetMap, 'road');
    expect(r.lat, -10.5);
    expect(r.lon, -20.5);
  });

  test('fromNumber constructor', () {
    final r = Region.fromNumber(49);
    expect(r.id, 1);
    expect(r.number, 49);
  });

  test('fromNumber error on unknown', () {
    expect(() => Region.fromNumber(-10), throwsStateError);
  });

  test('fromId constructor', () {
    final r = Region.fromId(1);
    expect(r.id, 1);
    expect(r.number, 49);
  });

  test('fromId error on unknown', () {
    expect(() => Region.fromId(-10), throwsStateError);
  });

  group('configuration tests', () {
    test('ids unique', () {
      final ids = Region.REGIONS.map((e) => e.id).toSet();
      expect(ids, hasLength(Region.REGIONS.length));
    });

    test('region numbers unique positive integers', () {
      final numbers = Region.REGIONS.map((e) => e.id).toSet();
      expect(numbers, hasLength(Region.REGIONS.length));

      for (final n in numbers) {
        expect(n > 0, true, reason: 'Region $n');
      }
    });

    //TODO? test('map files exist in assets', () {});
  });
}
