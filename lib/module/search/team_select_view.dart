import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../dao/teams.dart';
import '../../models/age_group.dart';
import '../../models/gender.dart';
import '../../models/region.dart';
import '../../models/team.dart';
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
        onPressed: () => Modular.to.pushNamed('/schedules/team/${t.code}'),
        child: Text(t.code),
      ),
      footer: Row(
        children: [
          Text(t.region.number.toString()),
          Text(t.division.toJSON()),
        ],
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
        child: Column(
          children: [
            FormBuilderChoiceChip(
              attribute: 'region',
              initialValue: 0,
              decoration: InputDecoration(labelText: 'Region'),
              options: Region.REGIONS
                  .map((r) => FormBuilderFieldOption(
                        value: r.number,
                        child: Text('${r.number}'),
                      ))
                  .toList(growable: false),
            ),
            FormBuilderChoiceChip(
              attribute: 'age',
              initialValue: '',
              decoration: InputDecoration(labelText: 'Age Group'),
              options: AgeGroup.AGES
                  .map((ag) => FormBuilderFieldOption(
                        value: ag.toString(),
                        child: Text(ag.toString()),
                      ))
                  .toList(growable: false),
            ),
            FormBuilderChoiceChip(
              attribute: 'gender',
              initialValue: '',
              decoration: InputDecoration(labelText: 'Gender'),
              options: Gender.GENDERS
                  .map((g) => g.long)
                  .map((g) => FormBuilderFieldOption(
                        value: g,
                        child: Text(g),
                      ))
                  .toList(growable: false),
            ),
            Text('Teams'),
            ValueListenableBuilder(
              valueListenable: teams,
              // ignore: avoid_types_on_closure_parameters
              builder: (context, Iterable<Team> value, child) {
                return GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: value.map(buildTeamTile).toList(growable: false),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
