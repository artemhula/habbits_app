import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey[300]!,
    primary: Colors.white,
    inverseSurface: Colors.grey[900],
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(),
);
