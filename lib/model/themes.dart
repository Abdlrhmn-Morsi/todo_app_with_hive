import 'package:flutter/material.dart';

class Themes {
  static final lightMode = ThemeData(
    primaryColor: Colors.grey.shade500,
    brightness: Brightness.light,
  );
  static final darkMode = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );
}
