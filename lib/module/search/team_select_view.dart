import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/getwidget.dart';

import '../../dao/teams.dart';
import '../../models/age_group.dart';
import '../../models/gender.dart';
import '../../models/region.dart';
import '../../models/team.dart';
import '../../routes_config.dart';
import '../../widgets/nav_bar.dart';

/// Search form for selecting a team
class TeamSelectView extends StatefulWidget {
  @override
  _TeamSelectViewState createState() => _TeamSelectViewState();
}

class _TeamSelectViewState extends State<TeamSelectView> with TeamsInjection {
  final GlobalKey<FormBuilderState> _fb = GlobalKey<FormBuilderState>();

  ValueNotifier<Iterable<Team>> teams = ValueNotifier<Iterable<Team>>([]);

  int _region;
  String _age;
  String _gender;

  @override
  void initState() {
    print('initState');
    teamsDAO.findTeams().then((value) => teams.value = value);
    super.initState();
  }

  void refilterTeams(Function updateValue) {
    updateValue();
    teamsDAO
        .findTeams(
          regionNumber: (_region == 0) ? null : _region,
          ageString: (_age == '') ? null : _age,
          genderLong: (_gender == '') ? null : _gender,
        )
        .then((value) => teams.value = value);
  }

  Widget buildTeamTile(Team t) {
    return GridTile(
      child: RaisedButton(
        key: ValueKey('teamResult_${t.code}'),
        onPressed: () => Routing.sailor(
          '/schedules/team',
          params: {'id': t.code},
        ),
        child: Text(t.code),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey('TeamSelectView'),
      appBar: buildNavBar('Select Team', context),
      body: FormBuilder(
        key: _fb,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormBuilderChoiceChip(
                name: 'region',
                initialValue: 0,
                spacing: 1,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                decoration: InputDecoration(
                  labelText: 'Region',
                  labelStyle: Theme.of(context).textTheme.headline6,
                  border: InputBorder.none,
                  isDense: true,
                ),
                onChanged: (v) => refilterTeams(() { _region = v;}),
                options: Region.REGIONS
                    .map(
                      (r) => FormBuilderFieldOption(
                        value: r.number,
                        child: Text(
                          '${r.number}',
                          key: ValueKey('regionChip_${r.number}'),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              FormBuilderChoiceChip(
                name: 'age',
                initialValue: '',
                spacing: 1,
                runSpacing: -12,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                decoration: InputDecoration(
                  labelText: 'Age Group',
                  labelStyle: Theme.of(context).textTheme.headline6,
                  border: InputBorder.none,
                  isDense: true,
                ),
                onChanged: (v) => refilterTeams(() { _age = v;}),
                options: AgeGroup.AGES
                    .map(
                      (ag) => FormBuilderFieldOption(
                        value: ag.toString(),
                        child: Text(
                          ag.toString(),
                          key: ValueKey('ageChip_${ag.cutoff}'),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              FormBuilderChoiceChip(
                name: 'gender',
                initialValue: '',
                decoration: InputDecoration(
                  labelText: 'Gender',
                  labelStyle: Theme.of(context).textTheme.headline6,
                  isDense: true,
                ),
                onChanged: (v) => refilterTeams(() { _gender = v;}),
                options: Gender.GENDERS
                    .map(
                      (g) => FormBuilderFieldOption(
                        value: g.long,
                        child: Text(
                          g.long,
                          key: ValueKey('genderChip_${g.short}'),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              Text(
                'Teams',
                style: Theme.of(context).textTheme.headline5,
              ),
              ValueListenableBuilder(
                valueListenable: teams,
                // ignore: avoid_types_on_closure_parameters
                builder: (context, Iterable<Team> value, child) {
                  print('Rebuilding teams: ${value.length}');
                  if (value.isEmpty) {
                    return GFListTile(
                      avatar: Icon(Icons.info_outline),
                      titleText: 'No teams found',
                      description: Text(
                        'Adjust the search parameters to be less restrictive',
                      ),
                    );
                  }
                  return Expanded(
                    child: GridView(
                      key: ValueKey('scrollResultTeams'),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      children:
                          value.map(buildTeamTile).toList(growable: false),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
