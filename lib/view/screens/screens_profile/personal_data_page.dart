import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../../theme/theme.dart';
import 'screens_options/about_app_page.dart';

class personal_data_page extends StatelessWidget {
  const personal_data_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: const PersonalDataPage(),
        );
      }),
    );
  }
}

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({Key? key}) : super(key: key);

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text('Персональные данные'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            filled: true,
                            hintText: 'Фамилия',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            filled: true,
                            hintText: 'Имя',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            filled: true,
                            hintText: 'Отчество',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            filled: true,
                            hintText: 'Номер телефона',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            filled: true,
                            hintText: 'Почта',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
