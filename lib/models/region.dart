import 'package:meta/meta.dart';

class Region {
  const Region({
    @required this.id,
    @required this.number,
    @required this.name,
    @required this.mapFile,
    @required this.lat,
    @required this.lon,
  });

  factory Region.fromNumber(int regionNumber) {
    return REGIONS.singleWhere((r) => r.number == regionNumber);
  }

  factory Region.fromId(int id) {
    return REGIONS.singleWhere((r) => r.id == id);
  }

  // ignore: non_constant_identifier_names
  static Set<Region> REGIONS = {
    Region(
      id: 1,
      number: 49,
      name: 'Stryker',
      mapFile: './img/Fields49.svg',
      lat: 37.737437,
      lon: -97.213361,
    ),
    Region(
        id: 2,
        number: 105,
        name: 'Southview',
        mapFile: './img/Fields105.svg',
        lat: 37.611328,
        lon: -97.367567),
    Region(
        id: 4,
        number: 208,
        name: 'West Wichita',
        mapFile: './img/Fields208.svg',
        lat: 37.842481,
        lon: -97.372607),
    Region(
        id: 5,
        number: 253,
        name: 'Valley Center',
        mapFile: './img/Fields253.svg',
        lat: 37.843271,
        lon: -97.365568),
    Region(
        id: 6,
        number: 491,
        name: 'Clearwater',
        mapFile: './img/Fields491.svg',
        lat: 37.503879,
        lon: -97.490616),
  };

  final int id;
  final int number;
  final String name;
  final String mapFile;
  final double lat;
  final double lon;

  //EQUALS only on ID?
}
