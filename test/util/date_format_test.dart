import 'package:ayso_ks/util/date_format.dart';
import 'package:test/test.dart';

void main() {
  test('toMediumString() - 6 cases', () {
    final testCases = {
      '2020-02-10 08:30': 'Feb 10, 8:30',
      '2020-02-10 10:30': 'Feb 10, 10:30',
      '2020-03-10 08:00': 'Mar 10, 8:00',
      '2020-03-10 08:05': 'Mar 10, 8:05',
      '2020-04-10 14:30': 'Apr 10, 2:30',
      '2020-05-01 20:00': 'May 1, 8:00',
    }..forEach((testCase, expectedResult) {
        expect(DateTime.parse(testCase).toMediumString(), expectedResult);
      });
  });
}
