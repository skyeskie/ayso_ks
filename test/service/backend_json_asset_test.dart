import 'package:ayso_ks/service/backend_json_asset.dart';
import 'package:flutter_test/flutter_test.dart';

import 'backend_spec.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  backendInterfaceSpec(() => BackendJsonAsset());
}
