import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:twitter_api/twitter_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data_config.dart';
import '../../widgets/error_box.dart';
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
    tweets.complete(_requestCancellations().then(_processResponse));
    super.initState();
  }

  Future _requestCancellations() {
    try {
      return _twitterOauth.getTwitterRequest(
        'GET',
        'statuses/user_timeline.json',
        options: {
          'screen_name': DataConfig.twitterUsername,
          'count': '10',
          'exclude_replies': 'true',
        },
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    }
  }

  Future _processResponse(dynamic response) {
    final content = json.decode(response.body);

    //TODO: Null-safety (first?['message'])
    if (content is Map && content['errors']?.first['message'] != null) {
      return Future.error(HttpException(content['errors'].first['message']));
    }

    return Future.value(content);
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
            return Column(children: [
              Spacer(flex: 5),
              ErrorBox.strOrExcept(snapshot.error),
              Spacer(),
              OutlineButton.icon(
                icon: Icon(Icons.open_in_browser, size: 16),
                label: Text('Check in Browser'),
                onPressed: () => launch(
                  'https://twitter.com/${DataConfig.twitterUsername}/',
                ),
              ),
              Spacer(flex: 15),
            ]);
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
