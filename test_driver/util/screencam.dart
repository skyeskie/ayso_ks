import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_driver_helper/flutter_driver_helper.dart';

class Screencam implements Screenshoter {
  Screencam(
    this._driver,
    String baseScreensDir, {
    this.enabled = true,
    this.withIndices = true,
  }) : _screensDir = '$baseScreensDir' {
    if (!enabled) return;
    Directory(_screensDir).createSync(recursive: true);
  }

  final FlutterDriver _driver;
  final String _screensDir;
  @override
  final bool enabled;
  @override
  final bool withIndices;
  int _nextScreenId = 1;

  @override
  Future<void> saveScreen(String name) async {
    if (!enabled) return;
    final bytes = await _driver.screenshot();
    final namePrefix = withIndices ? '${_nextScreenId++}_' : '';
    final path = '$_screensDir/$namePrefix$name.png';
    File(path).writeAsBytesSync(bytes);
  }

  @override
  TestAction screenshot(String name) =>
      TestAction(() => saveScreen(name), name: 'take screenshot $name');
}

//
//The `Screenshoter` uses a timestamp to create screenshot folders, which has a
//colon character (`:`) which is not allowed on NTFS on Windows.
//
//```
//FileSystemException: Exists failed, path = './build/screenshots/2020-09-02 21:31:53.730980' (OS Error: The filename, directory n
//    ame, or volume label syntax is incorrect.
//```
//
//As a simple verification it is the timestamp, overwriting the `Screenshoter`
// class to omit the timestamp sub-directory works.
//
//Fix options:
//- Remove the colon, either unconditionally or if running on Windows.
//- Could use a period (ie `2020-09-02 21.31.53`)
//- Allow disabling the timestamp sub-directory (workaround)
