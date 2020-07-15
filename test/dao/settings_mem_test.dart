import 'package:ayso_ks/dao/mem/settings.dart';

import '../mock/test_data.dart';
import 'settings_spec.dart';

void main() {
  settingsInterfaceReadSpec(
    () => SettingsInMemoryDAO(initData: TestData.settings),
  );
  settingsInterfaceWriteSpec(
    () => SettingsInMemoryDAO(initData: TestData.settings),
  );
}
