import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/nav_bar.dart';

class CancellationsView extends StatefulWidget {
  @override
  _CancellationsViewState createState() => _CancellationsViewState();
}

class _CancellationsViewState extends State<CancellationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar('Cancellations', context),
      body: WebView(
        initialUrl: 'https://twitter.com/AYSOKS',
      ),
    );
  }
}
