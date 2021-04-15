import 'package:ayso_ks/di_config.dart';
import 'package:ayso_ks/main.dart' as app;
import 'package:ayso_ks/service/twitter_mock.dart';

void main() {
  DIConfig.twitterDAO = MockTwitterApi();
  app.main();
}
