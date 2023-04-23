import 'package:flutter/material.dart';
import 'package:fok_kometa/stuffs/constant.dart';
import 'package:fok_kometa/view/android_app/screens/screens_main/services_page.dart';
import 'package:graphql/client.dart';

import '../../../models/service/service_model.dart';
import '../../../stuffs/graphql.dart';
import '../../../stuffs/widgets.dart';
import 'screens_main/bioritm_page.dart';
import 'screens_main/diets_page.dart';
import 'screens_main/sleep_page.dart';
import 'screens_profile/calculators_page.dart';

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
  late QueryOptions currentQuery;

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
                        children: [
                          const Icon(
                            Icons.shopping_bag_outlined,
                            size: 98,
                          ),
                          const Text('Магазин'),
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
                        children: [
                          const Icon(
                            Icons.apple_outlined,
                            size: 98,
                          ),
                          const Text('Диеты'),
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
                        children: [
                          const Icon(
                            Icons.bedtime_outlined,
                            size: 98,
                          ),
                          const Text('Сон'),
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
          Container(
            height: 20,
          ),
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
                    child: Column(
                      children: [
                        const Icon(
                          Icons.bedtime_rounded,
                          size: 42,
                        ),
                        const Text('Сон'),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
