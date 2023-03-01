// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/view/screens/4_profile_page.dart';
import 'package:fok_kometa/view/screens/1_first_page.dart';

import 'package:fok_kometa/view/screens/second_page.dart';
import 'package:fok_kometa/view/screens/third_page.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

class menu_page extends StatelessWidget {
  const menu_page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
// ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context, rootNavigator: true)
//                       .pushNamed("/login_page");
//                 },
//                 child: const Text('Назад'),
//               ),

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
          indicatorColor: Colors.blue.shade100,
          shadowColor: Colors.grey.shade100,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          iconTheme: MaterialStatePropertyAll(IconThemeData(size: 28)),
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
              icon: Icon(Icons.newspaper_outlined),
              selectedIcon: Icon(Icons.newspaper_outlined),
              label: '1',
            ),
            const NavigationDestination(
              icon: Icon(Icons.newspaper_outlined),
              label: '2',
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
