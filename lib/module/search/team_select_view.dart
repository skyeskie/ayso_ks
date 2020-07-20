import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

import '../../dao/teams.dart';
import '../../models/age_group.dart';
import '../../models/gender.dart';
import '../../models/region.dart';
import '../../models/team.dart';
import '../../routes_config.dart';
import '../../widgets/nav_bar.dart';

class TeamSelectView extends StatefulWidget {
  @override
  _TeamSelectViewState createState() => _TeamSelectViewState();
}

class _TeamSelectViewState extends State<TeamSelectView> with TeamsInjection {
  final GlobalKey<FormBuilderState> _fb = GlobalKey<FormBuilderState>();

  ValueNotifier<Iterable<Team>> teams = ValueNotifier<Iterable<Team>>([]);

  @override
  void initState() {
    print('initState');
    teamsDAO.findTeams().then((value) => teams.value = value);
    super.initState();
  }

  void refilterTeams(Map<String, dynamic> newVal) {
    final region = newVal['region'];
    final age = newVal['age'];
    final gender = newVal['gender'];
    teamsDAO
        .findTeams(
          regionNumber: (region == 0) ? null : region,
          ageString: (age == '') ? null : age,
          genderLong: (gender == '') ? null : gender,
        )
        .then((value) => teams.value = value);
  }

  Widget buildTeamTile(Team t) {
    return GridTile(
      child: RaisedButton(
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
      appBar: buildNavBar('Select Team', context),
      body: FormBuilder(
        key: _fb,
        onChanged: refilterTeams,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormBuilderChoiceChip(
                attribute: 'region',
                initialValue: 0,
                spacing: 1,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                decoration: InputDecoration(
                  labelText: 'Region',
                  labelStyle: Theme.of(context).textTheme.headline6,
                  border: InputBorder.none,
                ),
                options: Region.REGIONS
                    .map(
                      (r) => FormBuilderFieldOption(
                        value: r.number,
                        child: Text('${r.number}'),
                      ),
                    )
                    .toList(growable: false),
              ),
              FormBuilderChoiceChip(
                attribute: 'age',
                initialValue: '',
                spacing: 1,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                decoration: InputDecoration(
                  labelText: 'Age Group',
                  labelStyle: Theme.of(context).textTheme.headline6,
                  border: InputBorder.none,
                ),
                options: AgeGroup.AGES
                    .map(
                      (ag) => FormBuilderFieldOption(
                        value: ag.toString(),
                        child: Text(ag.toString()),
                      ),
                    )
                    .toList(growable: false),
              ),
              FormBuilderChoiceChip(
                attribute: 'gender',
                initialValue: '',
                decoration: InputDecoration(
                  labelText: 'Gender',
                  labelStyle: Theme.of(context).textTheme.headline6,
                ),
                options: Gender.GENDERS
                    .map((g) => g.long)
                    .map(
                      (g) => FormBuilderFieldOption(
                        value: g,
                        child: Text(g),
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
