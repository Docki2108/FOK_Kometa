import 'package:flutter/material.dart';
import 'package:fok_kometa/view/login_page.dart';
import 'package:fok_kometa/view/menu_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login_page',
      routes: {
        '/login_page': (BuildContext context) => const login_page(),
        '/menu_page': (BuildContext context) => const menu_page()
      },
    ),
  );
}
