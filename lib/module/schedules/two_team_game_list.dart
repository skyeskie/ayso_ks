import 'package:flutter/material.dart';

import '../../models/game.dart';

class TwoTeamGameList extends StatelessWidget {
  TwoTeamGameList({Key key, this.games})
      : listViewData = generateRows(games),
        super(key: key);

  final Iterable<Game> games;
  final List<RowInfo> listViewData;

  @override
  Widget build(BuildContext context) {
    if (listViewData.isEmpty) {
      return SizedBox(
        height: 50,
        child: ListTile(
          title: Align(
            child: Text('No games found'),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemExtent: 50,
        itemCount: listViewData.length,
        itemBuilder: (context, index) {
          print('Adding item $index');
          final info = listViewData.elementAt(index);

          // Bye info
          if (info.byesListing.isNotEmpty) {
            return ListTile(
              title: Text('Byes'),
              subtitle: Text(info.byesListing),
            );
          }

          //Date header
          if (info.isDateHeader) {
            return ListTile(title: Text(formatDate(info.game.startTime)));
          }

          //Game Row
          return Row(
            children: [
              Expanded(
                child: Text('Region ${info.game.region.number}'),
              ),
              Expanded(
                child: Text('Field ${info.game.field}'),
              ),
              Expanded(
                child: Text('${info.game.home} vs ${info.game.away}'),
              ),
            ],
          );
        },
      ),
    );
  }

  static List<RowInfo> generateRows(Iterable<Game> games) {
    final byes = <String>[];
    final rowData = <RowInfo>[];
    var lastStart = DateTime.fromMicrosecondsSinceEpoch(0);

    print('Iterating through ${games.length} games');
    for (final game in games) {
      if (game.isBye()) {
        byes.add(game.getTeamWithBye());
      } else {
        if (game.startTime.isAfter(lastStart)) {
          lastStart = game.startTime;
          rowData.add(RowInfo.dateHeader(game));
        }
        rowData.add(RowInfo(game));
      }
    }

    //Add byes
    if (byes.isNotEmpty) {
      print('Adding byes: ${byes.join(', ')}');
      rowData.insert(0, RowInfo.byeInfo(byes.join(', ')));
    }

    return rowData;
  }
}

class RowInfo {
  RowInfo(this.game)
      : isDateHeader = false,
        byesListing = '';
  RowInfo.dateHeader(this.game)
      : isDateHeader = true,
        byesListing = '';
  RowInfo.byeInfo(this.byesListing)
      : game = null,
        isDateHeader = false;

  final Game game;
  final bool isDateHeader;
  final String byesListing;
}

String formatDate(DateTime dt) {
  final sb = StringBuffer()
    ..writeAll([
      months[dt.month],
      ' ',
      dt.day,
      ', ',
      (dt.hour > 12) ? dt.hour - 12 : dt.hour,
      ':',
      if (dt.minute < 10) '0',
      dt.minute,
    ]);
  return sb.toString();
}

const List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'June',
  'July',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec',
];
