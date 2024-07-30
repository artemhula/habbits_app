import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey[300]!,
    primary: Colors.grey[200]!,
    inverseSurface: Colors.grey[900],
  ),
  textTheme: GoogleFonts.manropeTextTheme(),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.grey[900]),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey[800],
    selectionColor: Colors.grey[800],
    selectionHandleColor: Colors.grey[800],
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey[900]!,
    primary: Colors.grey[800]!,
    inverseSurface: Colors.grey[300],
  ),
  textTheme: GoogleFonts.manropeTextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.grey[300]),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey[300],
    selectionColor: Colors.grey[300],
    selectionHandleColor: Colors.grey[300],
  ),
);
