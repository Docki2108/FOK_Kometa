import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/supabase.credentials.dart';
import 'package:fok_kometa/theme/theme.dart';
import 'package:fok_kometa/view/login_page.dart';
import 'package:fok_kometa/view/menu_page.dart';
import 'package:fok_kometa/view/screens/5_profile_page.dart';
import 'package:fok_kometa/view/splash_screen_page.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'view/registration_page.dart';

import 'view/screens/screens_profile/options_page.dart';

void main() async {
  await Supabase.initialize(
      url: SupabaseCredentials.API_URL, anonKey: SupabaseCredentials.API_KEY);
  initializeDateFormatting('ru_RU', null).then(
    (_) => runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
            return MaterialApp(
                theme: notifier.darkTheme ? dark : light,
                debugShowCheckedModeBanner: false,
                initialRoute: login_page.route,
                routes: {
                  // animared_splash_screen_page.route: (BuildContext context) =>
                  //     const animared_splash_screen_page(),
                  // splash_screen_page.route: (BuildContext context) =>
                  //     const splash_screen_page(),
                  login_page.route: (BuildContext context) =>
                      const login_page(),
                  menu_page.route: (BuildContext context) => const menu_page(),
                  registration_page.route: (BuildContext context) =>
                      const registration_page(),
                });
          },
        ),
      ),
    ),
  );
}
