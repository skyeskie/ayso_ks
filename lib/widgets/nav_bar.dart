import 'package:flutter/material.dart';

AppBar buildNavBar(String title, BuildContext context) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.home),
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false, //All routes
        ),
      )
    ],
  );
}
