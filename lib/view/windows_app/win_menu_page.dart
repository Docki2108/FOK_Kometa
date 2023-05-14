import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fok_kometa/view/windows_app/screens/win_coachs_page.dart';
import 'package:fok_kometa/view/windows_app/win_login_page.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../services/auth.dart';
import '../../theme/theme.dart';
import 'screens/win_clients_page.dart';
import 'screens/win_diets_page.dart';
import 'screens/win_equipments_page.dart';
import 'screens/win_group_workout_page.dart';
import 'screens/win_news_page.dart';
import 'screens/win_services_page.dart';
import 'screens/win_test.dart';

class win_menu_page extends StatelessWidget {
  const win_menu_page({super.key});
  static const String route = "/win_menu_page";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: WinLoginPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class WinLoginPage extends StatefulWidget {
  @override
  _WinLoginPageState createState() => _WinLoginPageState();
}

class _WinLoginPageState extends State<WinLoginPage> {
  int index = 0;
  bool isSmallScreen = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      isSmallScreen = constraints.maxWidth < 600;
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              groupAlignment: BorderSide.strokeAlignCenter,
              extended: true,
              selectedIndex: index,
              backgroundColor: Colors.blueGrey[300],
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.newspaper_outlined),
                  selectedIcon: Icon(Icons.newspaper_rounded),
                  label: Text(
                    'Новости',
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_bag_outlined),
                  selectedIcon: Icon(Icons.shopping_bag),
                  label: Text(
                    'Витрина',
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people_alt_outlined),
                  selectedIcon: Icon(Icons.people_alt),
                  label: Text(
                    'Тренеры',
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_pin_outlined),
                  selectedIcon: Icon(Icons.person_pin),
                  label: Text(
                    'Клиенты',
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.spoke_outlined),
                  selectedIcon: Icon(Icons.spoke),
                  label: Text(
                    'Групповые тренировки',
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.food_bank_outlined),
                  selectedIcon: Icon(Icons.food_bank),
                  label: Text(
                    'Диеты',
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.splitscreen_outlined),
                  selectedIcon: Icon(Icons.splitscreen),
                  label: Text(
                    'Тренажеры',
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.text_snippet_outlined),
                  selectedIcon: Icon(Icons.text_snippet),
                  label: Text(
                    'Тест',
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.exit_to_app),
                  label: Text(
                    style: TextStyle(color: Colors.red),
                    'Выход',
                  ),
                ),
              ],
            ),
            Expanded(
              child: buildPages(),
            )
          ],
        ),
      );
    });
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return win_news_page();
      case 1:
        return win_services_page();
      case 2:
        return win_coachs_page();
      case 3:
        return win_clients_page();
      case 4:
        return win_group_workout_page();
      case 5:
        return win_diets_page();
      case 6:
        return win_equipments_page();
      case 7:
        return win_test();
      // case 3:
      //   {
      //     AuthServiceWin.winLogout();
      //     Navigator.pushReplacementNamed(context, win_login_page.route);
      //   }
    }
    return Container();
  }
}
