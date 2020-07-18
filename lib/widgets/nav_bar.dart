import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import '../routes_config.dart';

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
