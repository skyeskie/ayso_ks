import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:twitter_api/twitter_api.dart';

import '../../widgets/nav_bar.dart';

/// View for showing cancellations or other remote news
class CancellationsView extends StatefulWidget {
  @override
  _CancellationsViewState createState() => _CancellationsViewState();
}

class _CancellationsViewState extends State<CancellationsView> {
  final twitterApi _twitterOauth = GetIt.I.get<twitterApi>();

  final Completer tweets = Completer();

  @override
  void initState() {
    tweets.complete(_twitterOauth.getTwitterRequest(
      'GET',
      'statuses/user_timeline.json',
      options: {
        'screen_name': 'aysoks',
        'count': '10',
        'exclude_replies': 'true',
      },
    ).then((response) {
      return json.decode(response.body);
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey('CancellationsView'),
      appBar: buildNavBar('Cancellations', context),
      body: FutureBuilder(
        future: tweets.future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (!snapshot.hasData) {
            return Text('Loading...');
          }

          return ListView.builder(
            key: ValueKey('TwitterTimeline'),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final tweet = snapshot.data.elementAt(index);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: EmbeddedTweetView.fromTweet(Tweet.fromJson(tweet)),
              );
            },
          );
        },
      ),
    );
  }
}
