import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/hive/weight_model.dart';
import 'package:fok_kometa/theme/theme.dart';
import 'package:fok_kometa/view/android_app/forgot_password_page.dart';
import 'package:fok_kometa/view/android_app/login_page.dart';
import 'package:fok_kometa/view/android_app/menu_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'view/android_app/registration_page.dart';
import 'view/windows_app/win_login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'view/windows_app/win_menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(WeightAdapter());
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
            return MaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ru', 'RU'),
              ],
              theme: notifier.darkTheme ? dark : light,
              debugShowCheckedModeBanner: false,
              initialRoute: login_page.route,
              routes: {
                login_page.route: (BuildContext context) => const login_page(),
                menu_page.route: (BuildContext context) => const menu_page(),
                registration_page.route: (BuildContext context) =>
                    const registration_page(),
                forgot_password_page.route: (BuildContext content) =>
                    const forgot_password_page(),
              },
            );
          },
        ),
      ),
    );
  } else if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    runApp(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        initialRoute: win_login_page.route,
        routes: {
          win_login_page.route: (BuildContext context) =>
              const win_login_page(),
          win_menu_page.route: (BuildContext context) => win_menu_page(
                key: UniqueKey(),
              ),
        },
      ),
    );
  }
}
