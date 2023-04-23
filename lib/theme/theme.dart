// ignore_for_file: prefer_conditional_assignment, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// theme: FlexThemeData.light(
//         colors: const FlexSchemeColor(
//           primary: Color(0xff004881),
//           primaryContainer: Color(0xffd0e4ff),
//           secondary: Color(0xffac3306),
//           secondaryContainer: Color(0xffffdbcf),
//           tertiary: Color(0xff006875),
//           tertiaryContainer: Color(0xff95f0ff),
//           appBarColor: Color(0xffffdbcf),
//           error: Color(0xffb00020),
//         ),
//         surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
//         blendLevel: 9,
//         subThemesData: const FlexSubThemesData(
//           blendOnLevel: 10,
//           blendOnColors: false,
//         ),
//         visualDensity: FlexColorScheme.comfortablePlatformDensity,
//         useMaterial3: true,
//         swapLegacyOnMaterial3: true,
//         fontFamily: GoogleFonts.notoSans().fontFamily,
//       ),
//       darkTheme: FlexThemeData.dark(
//         colors: const FlexSchemeColor(
//           primary: Color(0xff9fc9ff),
//           primaryContainer: Color(0xff00325b),
//           secondary: Color(0xffffb59d),
//           secondaryContainer: Color(0xff872100),
//           tertiary: Color(0xff86d2e1),
//           tertiaryContainer: Color(0xff004e59),
//           appBarColor: Color(0xff872100),
//           error: Color(0xffcf6679),
//         ),
//         surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
//         blendLevel: 15,
//         subThemesData: const FlexSubThemesData(
//           blendOnLevel: 20,
//         ),
//         visualDensity: FlexColorScheme.comfortablePlatformDensity,
//         useMaterial3: true,
//         swapLegacyOnMaterial3: true,
//         fontFamily: GoogleFonts.notoSans().fontFamily,
//       ),

ThemeData light = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.light,
    accentColor: Color.fromARGB(255, 174, 228, 255),
    backgroundColor: Color.fromARGB(255, 155, 172, 200),
    primaryColorDark: Colors.blueGrey,
  ),
  useMaterial3: true, primaryColor: Colors.amber,
  brightness: Brightness.light,
  //primarySwatch: Colors.blueGrey,
  //accentColor: Colors.blueGrey,
  //scaffoldBackgroundColor: Color(0xfff1f1f1),
);

ThemeData dark = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    accentColor: Colors.blueGrey,
    backgroundColor: Color.fromARGB(255, 51, 51, 51),
    primaryColorDark: Colors.blueGrey,
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
  //primarySwatch: Colors.blueGrey,
  // accentColor: Colors.blueGrey,
  // scaffoldBackgroundColor: Color.fromARGB(255, 51, 51, 51),
);

class ThemeNotifier extends ChangeNotifier {
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
