// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/view/screens/5_profile_page.dart';
import 'package:fok_kometa/view/screens/1_first_page.dart';

import 'package:fok_kometa/view/screens/2_schedule_page.dart';
import 'package:fok_kometa/view/screens/3_services_page.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../view/login_page.dart';

import '../theme/theme.dart';
import 'screens/4_workout_page.dart';

class menu_page extends StatelessWidget {
  const menu_page({super.key});

  static const String route = "/menu_page";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: const Menu(),
          debugShowCheckedModeBanner: false,
        );
      }),
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
    const SchedulePage(),
    const ServicesPage(),
    const WorkoutPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedOut) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(login_page.route);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            //labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            elevation: 0.2,
            height: 80,
            // indicatorColor: Colors.blue.shade100,
            // shadowColor: Colors.grey.shade100,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            iconTheme: const MaterialStatePropertyAll(
              IconThemeData(size: 30),
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
                label: 'Новости',
              ),
              const NavigationDestination(
                icon: Icon(Icons.event_note_outlined),
                selectedIcon: Icon(Icons.event_note),
                label: 'Раписание',
              ),
              const NavigationDestination(
                icon: Icon(Icons.table_rows_outlined),
                selectedIcon: Icon(Icons.table_rows),
                label: 'Услуги',
              ),
              const NavigationDestination(
                icon: Icon(Icons.sports_outlined),
                selectedIcon: Icon(Icons.sports),
                label: 'Тренировки',
              ),
              const NavigationDestination(
                  icon: Icon(Icons.account_box_outlined),
                  selectedIcon: Icon(Icons.account_box),
                  label: 'Профиль'),
            ],
          ),
        ),
      ),
    );
  }
}
