import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:twitter_api/twitter_api.dart';

class MockTwitterApi implements twitterApi {
  static void register() =>
      GetIt.I.registerSingleton<twitterApi>(MockTwitterApi());

  @override
  Future<Response> getTwitterRequest(String method, String url,
      {Map<String, String> options, int timeout = 10}) async {
    final mockData = File('./test/mock/twitter_data.json');
    return Response(await mockData.readAsString(), 200);
  }
}
