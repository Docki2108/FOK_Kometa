import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/new_models/user.dart';
import 'package:provider/provider.dart';
import '../../../new_models/service_category.dart';
import '../../../theme/theme.dart';

class win_test extends StatelessWidget {
  const win_test({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: WinTest(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class WinTest extends StatefulWidget {
  @override
  _WinTestState createState() => _WinTestState();
}

class _WinTestState extends State<WinTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Витрина'),
        centerTitle: true,
      ),
      body: Center(),
    );
  }
}
