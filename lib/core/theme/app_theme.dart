import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Nurito',
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Color(0xFF121212),
    fontFamily: 'Nurito',
  );
}
