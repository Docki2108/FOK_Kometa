// ignore_for_file: prefer_conditional_assignment, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.light,
    accentColor: Color.fromARGB(255, 174, 228, 255),
    backgroundColor: Color.fromARGB(255, 216, 228, 255),
  ),
  useMaterial3: true,
  primaryColor: Colors.amber,
  brightness: Brightness.light,
);

ThemeData dark = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    accentColor: Colors.blueGrey,
    backgroundColor: Color.fromARGB(255, 51, 51, 51),
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
);

class ThemeNotifier extends ChangeNotifier {
  bool _useMaterial3 = true;
  bool get useMaterial3 => _useMaterial3;

  set useMaterial3(bool value) {
    _useMaterial3 = value;
    notifyListeners();
  }

  final String key = "theme";

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
