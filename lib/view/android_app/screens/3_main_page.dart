import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fok_kometa/stuffs/constant.dart';
import 'package:fok_kometa/view/android_app/screens/screens_main/coachs_page.dart';
import 'package:fok_kometa/view/android_app/screens/screens_main/services_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'screens_main/bioritm_page.dart';
import 'screens_main/diets_page.dart';
import 'screens_main/sleep_page.dart';
import 'screens_main/calculators_page.dart';

class main_page extends StatelessWidget {
  const main_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Center(
          child: Text('Главная страница'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Основное'),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 98,
                                  ),
                                  Text('Витрина'),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ServicesPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.apple_outlined,
                                    size: 98,
                                  ),
                                  Text('Диеты'),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DietsPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.people_outlined,
                                    size: 98,
                                  ),
                                  Text('Тренеры'),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoachesPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Наблюдение'),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.calculate_outlined,
                                    size: 42,
                                  ),
                                  Text('Калькуляторы'),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CalculatorsPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.border_inner_rounded,
                                    size: 42,
                                  ),
                                  Text('Биоритмы'),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BiorhythmCalculator(),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.bedtime_outlined,
                                    size: 42,
                                  ),
                                  Text('Сон'),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SleepCycleCalculator(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Image.asset(
                      'lib/theme/images/kometa-map.png',
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(230, 260, 0, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (await canLaunch(FOK_KOMETA_MAP_URL)) {
                              await launch(FOK_KOMETA_MAP_URL);
                            } else {
                              throw 'Ошибка перехода на URL: $FOK_KOMETA_MAP_URL';
                            }
                          } catch (e) {
                            log('Ошибка: $e');
                          }
                        },
                        child: const Text('Открыть карту'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
