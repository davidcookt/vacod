import 'package:flutter/material.dart';
import 'package:vacod/theme/theme.dart';

enum ThemeState { light, dark, black, system }

final Map<ThemeState, ThemeData> _themeData = {
  ThemeState.light: AppTheme.light,
  ThemeState.dark: AppTheme.dark,
};

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentThemeMode = ThemeMode.system;
  ThemeMode get currentThemeMode => _currentThemeMode;
  void doChangeTheme(ThemeState themeState) {
    if (themeState == ThemeState.light)
      _currentThemeMode = ThemeMode.light;
    else if (themeState == ThemeState.dark)
      _currentThemeMode = ThemeMode.dark;
    else
      _currentThemeMode = ThemeMode.system;
    notifyListeners();
  }
}
