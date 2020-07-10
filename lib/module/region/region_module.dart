import 'package:flutter_modular/flutter_modular.dart';

import 'field_view.dart';
import 'region_list_view.dart';
import 'street_map_view.dart';

class RegionModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', child: (ctx, args) => RegionListView()),
        Router('/list', child: (ctx, args) => RegionListView()),
        Router(
          '/:regionNum/field',
          child: (ctx, args) =>
              FieldView(int.parse(args.params['regionNum'], radix: 10)),
        ),
        Router(
          '/:regionNum/map',
          child: (ctx, args) =>
              StreetMapView(int.parse(args.params['regionNum'], radix: 10)),
        ),
      ];
}
