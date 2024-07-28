import 'package:flutter/material.dart';
import 'package:habits/theme/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = lightTheme;
  ThemeData get theme => _theme;
  bool get isDarkTheme => _theme == darkTheme;

  void toggleTheme() {
    if (_theme == lightTheme) {
      _theme = darkTheme;
    } else {
      _theme = lightTheme;
    }
    notifyListeners();
  }
}
