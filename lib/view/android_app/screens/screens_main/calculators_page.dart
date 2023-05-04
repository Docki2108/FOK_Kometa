import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../stuffs/constant.dart';

class CalculatorsPage extends StatefulWidget {
  const CalculatorsPage({super.key});

  @override
  State<CalculatorsPage> createState() => _CalculatorsPageState();
}

class _CalculatorsPageState extends State<CalculatorsPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double bmi = 0;
  int _activity = 0;
  double _result = 0;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();

    super.dispose();
  }

  void calculateBmi() {
    double weight = double.tryParse(_weightController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;

    setState(() {
      if (weight == null || height == null) bmi = 0;
      bmi = weight / (height * height);
    });
  }

  void clearBmi() {
    _weightController.clear();
    _heightController.clear();
    setState(() {
      bmi = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text('Калькуляторы'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(16),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: TextFormField(
                                      controller: _weightController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        calculateBmi();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        filled: true,
                                        labelText: 'Масса (кг)',
                                        labelStyle: TextStyle(height: 6),
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
                                      controller: _heightController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        calculateBmi();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        filled: true,
                                        labelText: 'Рост (м)',
                                        labelStyle: TextStyle(height: 6),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text('Уровень физической активности'),
                            Slider(
                              value: _activity.toDouble(),
                              min: -3,
                              max: 3,
                              divisions: 6,
                              onChanged: (value) {
                                setState(() {
                                  _activity = value.toInt();
                                });
                                _calculateWaterIntake('');
                              },
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                              ),
                              onPressed: clearBmi,
                              child: const Text("Очистить"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: const EdgeInsets.all(16),
                            elevation: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    "Индекс массы тела: ${bmi.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(342, 15, 22, 22),
                          child: IconButton(
                            icon: const Icon(
                              Icons.info_outline,
                              size: 22,
                            ),
                            tooltip: 'Информация об ИМТ',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('ИМТ'),
                                  content: SingleChildScrollView(
                                    child: Text(descriptionIMT),
                                  ),
                                  actions: <Widget>[
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
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
                      ],
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: const EdgeInsets.all(16),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    'Литров воды в день: ${_result.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(322, 10, 22, 22),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateWaterIntake(String value) {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double height = double.tryParse(_heightController.text) ?? 0;

    final double waterIntake =
        (weight / 30) + (height) + (_activity.toDouble() / 10);

    setState(() {
      _result = waterIntake;
    });
  }
}
