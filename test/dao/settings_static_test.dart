import 'package:ayso_ks/dao/static/settings.dart';

import 'settings_spec.dart';

void main() {
  settingsInterfaceReadSpec(() => SettingsStaticDAO());
  settingsInterfaceReadonlySpec(() => SettingsStaticDAO());
}
