import 'package:flutter/material.dart';

class CalculatorsPage extends StatefulWidget {
  const CalculatorsPage({super.key});

  @override
  State<CalculatorsPage> createState() => _CalculatorsPageState();
}

class _CalculatorsPageState extends State<CalculatorsPage> {
  //late int IMT;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text('Калькуляторы'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(16),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text('Расчет индекса массы тела'),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: TextFormField(
                                      //controller: loginController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintText: 'Масса тела',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: TextFormField(
                                      //controller: loginController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintText: 'Рост',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Рассчитать'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Text(IMT.toString()),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(322, 10, 22, 22),
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 2,
                        child: IconButton(
                          icon: const Icon(
                            Icons.info_outline,
                            size: 22,
                          ),
                          tooltip: 'Информация',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Описание групповых занятий'),
                                content: const SingleChildScrollView(),
                                actions: <Widget>[
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: const Text(
                                      'Ок',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(16),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text('Расчет индекса массы тела'),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: TextFormField(
                                      //controller: loginController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintText: 'Масса тела',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: TextFormField(
                                      //controller: loginController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintText: 'Рост',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Рассчитать'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(322, 10, 22, 22),
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 2,
                        child: IconButton(
                          icon: const Icon(
                            Icons.info_outline,
                            size: 22,
                          ),
                          tooltip: 'Информация',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Описание групповых занятий'),
                                content: const SingleChildScrollView(),
                                actions: <Widget>[
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: const Text(
                                      'Ок',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(16),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text('Расчет индекса массы тела'),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: TextFormField(
                                      //controller: loginController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintText: 'Масса тела',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: TextFormField(
                                      //controller: loginController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintText: 'Рост',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Рассчитать',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(322, 10, 22, 22),
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 2,
                        child: IconButton(
                          icon: const Icon(
                            Icons.info_outline,
                            size: 22,
                          ),
                          tooltip: 'Информация',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Описание групповых занятий'),
                                content: const SingleChildScrollView(),
                                actions: <Widget>[
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: const Text(
                                      'Ок',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
