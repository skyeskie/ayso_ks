import 'package:ayso_ks/models/division.dart';
import 'package:ayso_ks/models/region.dart';
import 'package:ayso_ks/models/team.dart';
@Tags(['model'])
import 'package:test/test.dart';

void main() {
  test('constructs minimally', () {
    final t = Team(code: 'code', coach: 'coach', coachTel: 'tel');
    expect(t.code, 'code');
    expect(t.coach, 'coach');
    expect(t.coachTel, 'tel');
    expect(t.division, null);
    expect(t.region, null);
  });

  test('constructs with all params', () {
    final t = Team(
      code: 'code',
      coach: 'coach',
      coachTel: 'tel',
      region: Region.fromNumber(49),
      division: Division.fromString('U10B'),
    );
    expect(t.code, 'code');
    expect(t.coach, 'coach');
    expect(t.coachTel, 'tel');
    expect(t.division.shortDisplayName(), 'U10B');
    expect(t.region.number, 49);
  });
}
