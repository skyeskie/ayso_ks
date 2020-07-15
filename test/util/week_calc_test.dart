import 'package:ayso_ks/util/week_calc.dart';
import 'package:test/test.dart';

void main() {
  final dates = [
    DateTime.parse('2020-01-01'), //1
    DateTime.parse('2020-01-08'), //2
    DateTime.parse('2020-01-15'), //3
    DateTime.parse('2020-01-16'), //4
    DateTime.parse('2020-01-20'), //5
    DateTime.parse('2020-02-01'), //6
    DateTime.parse('2020-02-08'), //7
  ];

  int _calc(String testTime) => calculateCurrentWeek(
        dates,
        now: DateTime.parse(testTime),
      );

  test('error without starts', () {
    expect(() => calculateCurrentWeek(null), throwsArgumentError);
    expect(() => calculateCurrentWeek([]), throwsArgumentError);
  });

  test('before first week is one', () {
    expect(_calc('2019-12-30'), 1);
  });

  test('week in middle', () {
    expect(_calc('2020-01-09'), 2);
    expect(_calc('2020-01-15 08:00'), 3);
  });

  test('at boundary matches new week', () {
    expect(_calc('2020-01-15'), 3);
  });

  test('non-standard gaps', () {
    expect(_calc('2020-01-16 08:00'), 4);
    expect(_calc('2020-01-28'), 5);
  });

  test('after last start is last week', () {
    expect(_calc('2020-02-10'), 7);
  });

  test('well after last start is last week', () {
    expect(_calc('2030-02-10'), 7);
  });

  test('using Now', () {
    expect(calculateCurrentWeek(dates), 7);
  });
}
