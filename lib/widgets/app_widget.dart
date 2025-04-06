import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppWidget {
  static TextStyle boldTextStye() {
    return TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headlineTextStye() {
    return TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle lightTextStye() {
    return TextStyle(
      color: const Color.fromARGB(255, 116, 114, 114),
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle samiBoolTextStye() {
    return TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }
}
