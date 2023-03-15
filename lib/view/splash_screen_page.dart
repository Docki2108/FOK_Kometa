import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'login_page.dart';

class splash_screen_page extends StatefulWidget {
  const splash_screen_page({super.key});
  static const String route = "/splash_screen_page";

  @override
  State<splash_screen_page> createState() => _splash_screen_pageState();
}

class _splash_screen_pageState extends State<splash_screen_page> {
  // @override
  // void initState() {
  //   super.initState();
  //   _navigatetohome();
  // }

  // _navigatetohome() async {
  //   await Future.delayed(Duration(milliseconds: 1500), () {});
  //   Navigator.of(context, rootNavigator: true).pushNamed("/login_page");
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        animationDuration: const Duration(milliseconds: 1000),
        duration: 3000,
        splash: const Text(
          'ФОК',
          style: TextStyle(fontSize: 48),
        ),
        nextScreen: const LoginPage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color.fromARGB(255, 223, 235, 245),
      ),
    );
  }
}
