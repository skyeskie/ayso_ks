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
      appBar: buildNavBar('Cancellations', context),
      body: FutureBuilder(
        future: tweets.future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //TODO
            return Text(snapshot.error);
          }

          if (!snapshot.hasData) {
            return Text('Loading...');
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final tweet = snapshot.data.elementAt(index);
              print(jsonEncode(tweet).length);
              return EmbeddedTweetView.fromTweet(Tweet.fromJson(tweet));
            },
          );
        },
      ),
    );
  }
}
