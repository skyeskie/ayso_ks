import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import '../routes_config.dart';

/// Application navigation bar for [title]
///
/// This is extracted here for common styling across multiple views
AppBar buildNavBar(String title, BuildContext context) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.home),
        onPressed: () => Routing.sailor(
          '/',
          navigationType: NavigationType.pushAndRemoveUntil,
          removeUntilPredicate: (route) => false, //All routes
        ),
      )
    ],
  );
}
