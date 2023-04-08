import 'dart:math';

import 'package:flutter/material.dart';

import '../../../stuffs/constant.dart';

class CalculatorsPage extends StatefulWidget {
  const CalculatorsPage({super.key});

  @override
  State<CalculatorsPage> createState() => _CalculatorsPageState();
}

class _CalculatorsPageState extends State<CalculatorsPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double bmi = 0;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();

    _weightController2.dispose();

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

  final TextEditingController _weightController2 = TextEditingController();
  int _activityLevel = 0;
  double _dailyWaterIntake = 0;

  void calculateDailyWaterIntake() {
    double weight = double.tryParse(_weightController2.text) ?? 0;
    double activityFactor = 0;

    switch (_activityLevel) {
      case 1:
        activityFactor = 0.5;
        break;
      case 2:
        activityFactor = 0.6;
        break;
      case 3:
        activityFactor = 0.7;
        break;
      case 4:
        activityFactor = 0.8;
        break;
      case 5:
        activityFactor = 0.9;
        break;
      default:
        activityFactor = 0.4;
        break;
    }

    setState(() {
      _dailyWaterIntake = weight * 0.03 * activityFactor;
    });
  }

  void clearDailyWaterIntake() {
    _weightController2.clear();
    setState(() {
      _activityLevel = 0;
      _dailyWaterIntake = 0;
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
      body: SingleChildScrollView(
        child: Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          hintText: 'Масса (кг)',
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
                                          hintText: 'Рост (м)',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                (bmi == null ||
                                        _weightController == null ||
                                        _heightController == null)
                                    ? ""
                                    : "Индекс массы тела: ${bmi.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: clearBmi,
                                child: const Text("Очистить"),
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
                              TextField(
                                controller: _weightController,
                                decoration: const InputDecoration(
                                  labelText: "Ваш вес (кг)",
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                """Уровень физической активности""",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RadioListTile<int>(
                                title: const Text('Очень низкий'),
                                value: 1,
                                groupValue: _activityLevel,
                                onChanged: (value) {
                                  setState(() {
                                    _activityLevel = value!;
                                  });
                                },
                              ),
                              RadioListTile<int>(
                                title: const Text('Низкий'),
                                value: 2,
                                groupValue: _activityLevel,
                                onChanged: (value) {
                                  setState(() {
                                    _activityLevel = value!;
                                  });
                                },
                              ),
                              RadioListTile<int>(
                                title: const Text('Средний'),
                                value: 3,
                                groupValue: _activityLevel,
                                onChanged: (value) {
                                  setState(() {
                                    _activityLevel = value!;
                                  });
                                },
                              ),
                              RadioListTile<int>(
                                title: const Text('Высокий'),
                                value: 4,
                                groupValue: _activityLevel,
                                onChanged: (value) {
                                  setState(() {
                                    _activityLevel = value!;
                                  });
                                },
                              ),
                              RadioListTile<int>(
                                  title: const Text('Очень высокий'),
                                  value: 5,
                                  groupValue: _activityLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _activityLevel = value!;
                                    });
                                  }),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _weightController.text.isNotEmpty
                                    ? calculateDailyWaterIntake
                                    : null,
                                child: const Text("Рассчитать"),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _dailyWaterIntake.toStringAsFixed(2) + " л",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: clearDailyWaterIntake,
                                child: const Text("Очистить"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(322, 10, 22, 22),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  title:
                                      const Text('Описание групповых занятий'),
                                  content: const SingleChildScrollView(),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
