import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/supabase.credentials.dart';
import 'package:fok_kometa/view/login_page.dart';
import 'package:fok_kometa/view/menu_page.dart';
import 'package:fok_kometa/view/screens/5_profile_page.dart';
import 'package:fok_kometa/view/splash_screen_page.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'view/registration_page.dart';

import 'view/screens/screens_profile/options_page.dart';

void main() async {
  await Supabase.initialize(
      url: SupabaseCredentials.API_URL, anonKey: SupabaseCredentials.API_KEY);
  initializeDateFormatting('ru_RU', null).then(
    (_) => runApp(
      MaterialApp(
        theme: FlexThemeData.light(
          colors: const FlexSchemeColor(
            primary: Color(0xff004881),
            primaryContainer: Color(0xffd0e4ff),
            secondary: Color(0xffac3306),
            secondaryContainer: Color(0xffffdbcf),
            tertiary: Color(0xff006875),
            tertiaryContainer: Color(0xff95f0ff),
            appBarColor: Color(0xffffdbcf),
            error: Color(0xffb00020),
          ),
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 9,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        darkTheme: FlexThemeData.dark(
          colors: const FlexSchemeColor(
            primary: Color(0xff9fc9ff),
            primaryContainer: Color(0xff00325b),
            secondary: Color(0xffffb59d),
            secondaryContainer: Color(0xff872100),
            tertiary: Color(0xff86d2e1),
            tertiaryContainer: Color(0xff004e59),
            appBarColor: Color(0xff872100),
            error: Color(0xffcf6679),
          ),
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 15,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: splash_screen_page.route,
        routes: {
          // animared_splash_screen_page.route: (BuildContext context) =>
          //     const animared_splash_screen_page(),
          splash_screen_page.route: (BuildContext context) =>
              const splash_screen_page(),
          login_page.route: (BuildContext context) => const login_page(),
          menu_page.route: (BuildContext context) => const menu_page(),
          registration_page.route: (BuildContext context) =>
              const registration_page(),
        },
      ),
    ),
  );
}
