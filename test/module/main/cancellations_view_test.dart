import 'dart:async';
import 'dart:convert';

import 'package:ayso_ks/module/main/cancellations_view.dart';
import 'package:ayso_ks/service/twitter_mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/src/response.dart';
import 'package:twitter_api/twitter_api.dart';

import '../../mock/test_it.dart';

void main() {
  tearDown(TestIt.clean);

  testWidgets('display', (tester) async {
    TestIt.registerTwitter();

    await tester.pumpWidget(MaterialApp(home: CancellationsView()));
    expect(find.text('Cancellations'), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
    expect(find.byKey(ValueKey('TwitterTimeline')), findsNothing);

    await tester.pumpAndSettle();

    expect(find.text('Loading...'), findsNothing);
    expect(find.byKey(ValueKey('TwitterTimeline')), findsOneWidget);
  });

  testWidgets('rate limit', (tester) async {
    //HTTP/1.1 429 Too Many Requests
    //{"errors":[{"message":"Rate limit exceeded","code":88}]}
    TestIt.I.registerSingleton<twitterApi>(
      TwitterError(
          429,
          {
            'errors': [
              {
                'message': 'Rate limit exceeded',
                'code': 88,
              }
            ]
          },
          reasonPhrase: 'Too Many Requests'),
    );

    await tester.pumpWidget(MaterialApp(home: CancellationsView()));

    await tester.pumpAndSettle();

    expect(find.text('HTTP Error'), findsOneWidget);
    expect(find.text('Rate limit exceeded'), findsOneWidget);
  });

  testWidgets('timeout', (tester) async {
    TestIt.I.registerSingleton<twitterApi>(
      TwitterThrowError(TimeoutException('Timeout!')),
    );

    await tester.pumpWidget(MaterialApp(home: CancellationsView()));

    await tester.pumpAndSettle();

    expect(find.text('Timeout Error'), findsOneWidget);
    expect(find.text('Timeout!'), findsOneWidget);
  });
}

/// Mock to return a valid JSON payload from [response] map
class TwitterError implements MockTwitterApi {
  TwitterError(this.statusCode, this.response, {this.reasonPhrase});

  final int statusCode;
  final Map<String, dynamic> response;
  final String reasonPhrase;

  @override
  Future<Response> getTwitterRequest(
    String method,
    String url, {
    Map<String, String> options,
    int timeout = 10,
  }) {
    return Future.value(Response(
      jsonEncode(response),
      statusCode,
      reasonPhrase: reasonPhrase,
    ));
  }
}

/// Mock to throw specified exception [error]
class TwitterThrowError implements MockTwitterApi {
  TwitterThrowError(this.error);
  final Exception error;

  @override
  Future<Response> getTwitterRequest(
    String method,
    String url, {
    Map<String, String> options,
    int timeout = 10,
  }) {
    throw error;
  }
}
