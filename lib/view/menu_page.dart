// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/view/screens/4_profile_page.dart';
import 'package:fok_kometa/view/screens/1_first_page.dart';

import 'package:fok_kometa/view/screens/2_records_page.dart';
import 'package:fok_kometa/view/screens/3_card_page.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

class menu_page extends StatelessWidget {
  const menu_page({super.key});

  static const String route = "/menu_page";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const Menu(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int index = 0;
  final screens = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
    const FourPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          //labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          elevation: 0.2,
          height: 80,
          // indicatorColor: Colors.blue.shade100,
          // shadowColor: Colors.grey.shade100,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          iconTheme: const MaterialStatePropertyAll(
            IconThemeData(size: 28),
          ),
        ),
        child: NavigationBar(
          // animationDuration: const Duration(seconds: 1),
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Главная',
            ),
            const NavigationDestination(
              icon: Icon(Icons.table_rows_outlined),
              selectedIcon: Icon(Icons.table_rows),
              label: 'Раписание',
            ),
            const NavigationDestination(
              icon: Icon(Icons.pages_outlined),
              selectedIcon: Icon(Icons.pages),
              label: 'Пропуск',
            ),
            const NavigationDestination(
                icon: Icon(Icons.account_box_outlined),
                selectedIcon: Icon(Icons.account_box),
                label: 'Профиль'),
          ],
        ),
      ),
    );
  }
}