import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

/// Widget to display an error message in a formatted card
class ErrorBox extends StatelessWidget {
  /// Create an error box directly with specified [message]
  ///
  /// The heading may be input as [title], otherwise "Error" will be used
  ErrorBox(this.message, {Key key, this.title = 'Error'}) : super(key: key);

  /// Create an error box from either a [String] or an [Exception]
  ///
  /// As a fallback, it will try to use [toString] on the [message]
  factory ErrorBox.strOrExcept(dynamic message) {
    if (message is String) {
      return ErrorBox(message);
    }

    if (message is Exception) {
      return ErrorBox.fromException(message);
    }

    return ErrorBox(message.toString());
  }

  /// Create an error box from an [Exception] object
  ///
  /// It will specifically recognize several types including:
  /// [TimeoutException], [HttpException]
  /// Otherwise, it'll use the default [toString()] on the exception
  factory ErrorBox.fromException(Exception e) {
    if (e is TimeoutException) {
      return ErrorBox(e.message, title: 'Timeout Error');
    }

    if (e is HttpException) {
      return ErrorBox(e.message, title: 'HTTP Error');
    }

    return ErrorBox(e.toString());
  }

  /// Main message shown in the content of the error box
  final String message;

  /// Heading shown in the error box
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red[100],
      child: ListTile(
        leading: Icon(Icons.error_outline, color: Colors.red[900]),
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Color.fromRGBO(150, 0, 0, 1.0),
              ),
        ),
        subtitle: Text(
          message,
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Color.fromRGBO(60, 0, 0, 1.0),
              ),
        ),
      ),
    );
  }
}
