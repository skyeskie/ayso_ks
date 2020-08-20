import 'package:meta/meta.dart';

/// Data class for information on a region
class Region {
  /// Constant constructor
  ///
  /// Avoid using in-app, since this is a configuration class
  const Region({
    @required this.id,
    @required this.number,
    @required this.name,
    @required this.fieldMap,
    @required this.streetMap,
    @required this.lat,
    @required this.lon,
  });

  /// Return configured region for given region number
  factory Region.fromNumber(int regionNumber) {
    return REGIONS.singleWhere((r) => r.number == regionNumber);
  }

  /// Return configured region for given ID
  factory Region.fromId(int id) {
    return REGIONS.singleWhere((r) => r.id == id);
  }

  //TODO: Make map images show location marker
  //TODO: Make map image for each region
  //TODO: Make sure location marker onscreen for each

  /// Enumeration of all regions
  ///
  /// This is the configuration for the app over which regions to handle
  // ignore: non_constant_identifier_names
  static Set<Region> REGIONS = {
    Region(
      id: 1,
      number: 49,
      name: 'Stryker',
      fieldMap: 'img/Fields49.svg',
      streetMap: 'img/osm_region49_1500sq.png',
      lat: 37.737437,
      lon: -97.213361,
    ),
    Region(
      id: 2,
      number: 105,
      name: 'Southview',
      fieldMap: 'img/Fields105.svg',
      streetMap: 'img/osm_region49_1500sq.png',
      lat: 37.611328,
      lon: -97.367567,
    ),
    Region(
      id: 4,
      number: 208,
      name: 'West Wichita',
      fieldMap: 'img/Fields208.svg',
      streetMap: 'img/osm_region49_1500sq.png',
      lat: 37.842481,
      lon: -97.372607,
    ),
    Region(
      id: 5,
      number: 253,
      name: 'Valley Center',
      fieldMap: 'img/Fields253.svg',
      streetMap: 'img/osm_region49_1500sq.png',
      lat: 37.843271,
      lon: -97.365568,
    ),
    Region(
      id: 6,
      number: 491,
      name: 'Clearwater',
      fieldMap: 'img/Fields491.svg',
      streetMap: 'img/osm_region49_1500sq.png',
      lat: 37.503879,
      lon: -97.490616,
    ),
  };

  /// Short ID number
  ///
  /// No inherent property, but a single-digit number for identifying the
  /// regions in the Wichita area. Avoid using if adapting for other areas
  final int id;

  /// National AYSO region number
  ///
  /// This is a country-wide unique positive integer given to each region
  final int number;

  /// Description of a region
  ///
  /// Usually a short description of where the fields are
  final String name;

  /// Asset SVG that shows the map of the fields
  final String fieldMap;

  /// Asset image that shows the street map of the region
  final String streetMap;

  /// Latitude where the fields are located
  final double lat;

  /// Longitude where the fields are located
  final double lon;

  //EQUALS only on ID?
}
