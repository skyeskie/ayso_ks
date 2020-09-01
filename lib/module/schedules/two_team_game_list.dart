import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../routes_config.dart';
import '../../util/date_format.dart';

/// Game list widget
class TwoTeamGameList extends StatelessWidget {
  /// Creates the game listing
  ///
  /// Note: this immediately processes the games into rows
  TwoTeamGameList({Key key, @required this.games})
      : listViewData = generateRows(games),
        super(key: key);

  /// Games that are displayed in the listing
  final Iterable<Game> games;

  /// Row info - includes games, date headers, and byes
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
        itemExtent: 45,
        itemCount: listViewData.length,
        itemBuilder: (context, index) {
          print('Adding item $index');
          final info = listViewData.elementAt(index);

          // Bye info
          if (info.byesListing.isNotEmpty) {
            return ListTile(
              title: Text(
                'Byes',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(info.byesListing, textAlign: TextAlign.center),
            );
          }

          //Date header
          if (info.isDateHeader) {
            return ListTile(
              title: Align(
                alignment: Alignment(-0.8, 0.9),
                child: Text(
                  info.game.startTime.toMediumString(),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            );
          }

          //Game Row
          return GestureDetector(
            onTap: () => Routing.sailor(
              '/schedules/game',
              params: {'id': info.game.id},
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Text('Region ${info.game.region.number}'),
                ),
                Expanded(
                  child: Text('Field ${info.game.field}'),
                ),
                Expanded(
                  child: Text('${info.game.home} vs ${info.game.away}'),
                ),
                SizedBox(width: 10),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Static helper function to determine rows and headers for a list of games
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

/// Single line to display, whether game content or header
///
/// Row is a bye header if [byesListing] has length > 1
/// Row is a date/time header if [isDateHeader] is set
/// Otherwise the row is a game data row
class RowInfo {
  /// Create a row that displays game information
  RowInfo(this.game)
      : isDateHeader = false,
        byesListing = '';

  /// Create a row that displays a header for a particular time
  RowInfo.dateHeader(this.game)
      : isDateHeader = true,
        byesListing = '';

  /// Create a bye listing header
  RowInfo.byeInfo(this.byesListing)
      : game = null,
        isDateHeader = false;

  /// Game information. This is present as long as this isn't a bye header
  final Game game;

  /// Flag indicating this is a date/time header. False for bye headers
  final bool isDateHeader;

  /// Comma-separated list of byes to display
  ///
  /// If this is non-empty, this row is a bye header
  final String byesListing;
}
