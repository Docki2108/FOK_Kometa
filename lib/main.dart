import 'package:flutter/material.dart';
import 'package:fok_kometa/view/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  runApp(const MyApp());
  const MaterialApp(debugShowCheckedModeBanner: false);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const login_page(),
      // initialRoute: "/",
      // routes: {
      //   "/login_page": (final context) => const login_page(),
      //   //"/second": (final context) => const MainScreen3(),
      // },
    );
  }
}
