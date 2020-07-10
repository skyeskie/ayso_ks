import 'package:flutter_modular/flutter_modular.dart';

import 'search_view.dart';
import 'team_select_view.dart';

class SearchModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', child: (ctx, args) => SearchView()),
        Router('/teams', child: (ctx, args) => TeamSelectView()),
      ];
}
