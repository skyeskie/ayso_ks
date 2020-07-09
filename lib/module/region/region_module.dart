import 'package:flutter_modular/flutter_modular.dart';

import 'field_view.dart';
import 'region_list_view.dart';
import 'street_map_view.dart';

class RegionModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/list', child: (ctx, args) => RegionListView()),
        Router(
          '/:regionNum/field',
          child: (ctx, args) => FieldView(args.params['regionNum']),
        ),
        Router(
          '/:regionNum/map',
          child: (ctx, args) => StreetMapView(args.params['regionNum']),
        ),
      ];
}
