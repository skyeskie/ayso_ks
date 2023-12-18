import 'models/age_group.dart';
import 'models/gender.dart';
import 'models/region.dart';

// ignore: avoid_classes_with_only_static_members
/// Configuration for data limits on Models
///
/// Do not access this directly. Instead use the static accessor on the various
/// model classes ([AgeGroup.AGES], [Gender.GENDERS], [Region.REGIONS])
class DataConfig {
  static const String updateUrl = '';

  /// Twitter username to pull cancellations from
  static const String twitterUsername = 'aysoks';

  /// Configuration of all age groupings
  ///
  /// See [AgeGroup] for code and cutoff description
  static Set<AgeGroup> ages = {
    AgeGroup(code: 1, cutoff: 19),
    AgeGroup(code: 2, cutoff: 16),
    AgeGroup(code: 3, cutoff: 14),
    AgeGroup(code: 4, cutoff: 12),
    AgeGroup(code: 5, cutoff: 10),
    AgeGroup(code: 6, cutoff: 8),
    AgeGroup(code: 7, cutoff: 6),
    //AgeGroup(code: 8, cutoff: 5),
  };

  /// Configuration of gender divisions
  ///
  /// See [Gender] for more information
  static Set<Gender> genders = {
    Gender(short: 'B', long: 'Boys'),
    Gender(short: 'G', long: 'Girls'),
    Gender(short: 'C', long: 'Coed'),
  };

  /// Configuration of regions for the app to handle
  ///
  /// See [Region] for detailed description of parameters
  /// Note: As of now, all regions configured will be selectable in the app.
  static Set<Region> regions = {
    Region(
      id: 1,
      number: 49,
      name: 'Stryker',
      fieldMap: 'img/Fields49.svg',
      streetMap: 'img/osm_region49_1500sq_mk.png',
      lat: 37.737437,
      lon: -97.213361,
    ),
    Region(
      id: 2,
      number: 105,
      name: 'Southview',
      fieldMap: 'img/Fields105.svg',
      streetMap: 'img/osm_region105_1500sq_mk.png',
      lat: 37.611328,
      lon: -97.367567,
    ),
    Region(
      id: 4,
      number: 208,
      name: 'West Wichita',
      fieldMap: 'img/Fields208.svg',
      streetMap: 'img/osm_region208_1500sq_mk.png',
      lat: 37.71362,
      lon: -97.42445,
    ),
    Region(
      id: 5,
      number: 253,
      name: 'Valley Center',
      fieldMap: 'img/Fields253.svg',
      streetMap: 'img/osm_region253_1500sq_mk.png',
      lat: 37.843271,
      lon: -97.365568,
    ),
    Region(
      id: 6,
      number: 491,
      name: 'Clearwater',
      fieldMap: 'img/Fields491.svg',
      streetMap: 'img/osm_region491_1500sq_mk.png',
      lat: 37.503879,
      lon: -97.490616,
    ),
  };
}
