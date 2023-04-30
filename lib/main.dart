import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/theme/theme.dart';
import 'package:fok_kometa/view/android_app/login_page.dart';
import 'package:fok_kometa/view/android_app/menu_page.dart';
import 'package:provider/provider.dart';
import 'view/android_app/registration_page.dart';
import 'view/windows_app/win_login_page.dart';

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
            return MaterialApp(
                theme: notifier.darkTheme ? dark : light,
                debugShowCheckedModeBanner: false,
                initialRoute: login_page.route,
                routes: {
                  login_page.route: (BuildContext context) =>
                      const login_page(),
                  menu_page.route: (BuildContext context) => const menu_page(),
                  registration_page.route: (BuildContext context) =>
                      const registration_page(),
                });
          },
        ),
      ),
    );
  } else if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WinLoginPage(),
      ),
    );
  } else {}
}
