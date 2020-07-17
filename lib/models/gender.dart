import 'package:meta/meta.dart';

class Gender {
  const Gender({
    @required this.short,
    @required this.long,
  });

  factory Gender.fromCode(String code) {
    return GENDERS.singleWhere(
      (gender) => gender.short == code,
      orElse: () => null,
    );
  }

  // ignore: non_constant_identifier_names
  static const Set<Gender> GENDERS = {
    Gender(short: 'B', long: 'Boys'),
    Gender(short: 'G', long: 'Girls'),
    Gender(short: 'C', long: 'Coed'),
  };

  final String short;
  final String long;

  //EQUALS only on long?
}
