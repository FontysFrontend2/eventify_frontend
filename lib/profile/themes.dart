import 'package:flutter/material.dart';

class Themes {
  static const first = Colors.blue;
  static final firstColor = Colors.blue.shade300;

  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: firstColor,
    colorScheme: const ColorScheme.dark(primary: first),
    dividerColor: Colors.white,
  );

  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: firstColor,
    colorScheme: ColorScheme.light(primary: first),
    dividerColor: Colors.black,
  );
}
