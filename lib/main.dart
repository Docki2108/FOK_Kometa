import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fok_kometa/view/login_page.dart';
import 'package:fok_kometa/view/menu_page.dart';
import 'package:fok_kometa/view/splash_screen_page.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'view/registration_page.dart';

void main() {
  initializeDateFormatting('ru_RU', null).then(
    (_) => runApp(
      MaterialApp(
        theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
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
