// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  //When the state changes, ChangeNotifier notifies listeners. this class has been intertwined with a changenotifier
  bool _isDarkMode =
      false; //underscore (_) before the variable name indicates that it is private to the ThemeProvider class.

  bool get isDarkMode =>
      _isDarkMode; //a getter named isDarkMode returns the value of the private variable _isDarkMode.

  ThemeMode get currentTheme => _isDarkMode
      ? ThemeMode.dark
      : ThemeMode
          .light; //a ternary operatoris used to return ThemeMode.dark if _isDarkMode is true, otherwise it returns ThemeMode.light.

  void toggleTheme() {
    // method will be used to switch between dark and light modes.
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
