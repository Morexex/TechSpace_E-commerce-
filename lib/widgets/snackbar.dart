import 'package:flutter/material.dart';

class MyMessageHandler {
  // ignore: no_leading_underscores_for_local_identifiers
  static void showSnackbar(var _scafoldKey, String message) {
    _scafoldKey.currentState!.hideCurrentSnackBar();
    _scafoldKey.currentState!.showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.yellow,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        )));
  }
}
