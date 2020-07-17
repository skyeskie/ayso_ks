import 'package:ayso_ks/service/json_model.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

void main() {
  final fields = [
    Tuple3('049 Bye', 49, 'Bye'),
    Tuple3('049 Field 02', 49, '02'),
    Tuple3('049 Field 06A', 49, '06A'),
    Tuple3('049 Field 06B', 49, '06B'),
    Tuple3('049 Field 07', 49, '07'),
    Tuple3('049 Field 08', 49, '08'),
    Tuple3('049 Field 09A', 49, '09A'),
    Tuple3('049 Field 09B', 49, '09B'),
    Tuple3('049 Field 10E', 49, '10E'),
    Tuple3('049 Field 10W', 49, '10W'),
    Tuple3('105 Black', 105, 'Black'),
    Tuple3('105 Blue', 105, 'Blue'),
    Tuple3('105 Green', 105, 'Green'),
    Tuple3('105 Pink', 105, 'Pink'),
    Tuple3('105 Red', 105, 'Red'),
    Tuple3('208 Purple', 208, 'Purple'),
    Tuple3('208 Red', 208, 'Red'),
    Tuple3('208 Yellow', 208, 'Yellow'),
    Tuple3('253 Field 3', 253, '3'),
    Tuple3('253 Field 4', 253, '4'),
    Tuple3('253 Field 5', 253, '5'),
    Tuple3('253 Field 7', 253, '7'),
    Tuple3('491 Clearwater', 491, 'Clearwater'),
    Tuple3('Bye', null, 'Bye'),
  ];

  test('parseGameField', () {
    for (final field in fields) {
      final res = JsonModel.parseGameField(field.item1);
      expect(res.item1?.number, field.item2);
      expect(res.item2, field.item3);
    }
  });
}
