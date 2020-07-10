import 'package:flutter/material.dart';

class CancellationsView extends StatefulWidget {
  @override
  _CancellationsViewState createState() => _CancellationsViewState();
}

class _CancellationsViewState extends State<CancellationsView> {
  //TODO Inject Twitter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancellations'),
      ),
    );
  }
}
