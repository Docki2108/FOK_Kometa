import 'dart:math';
import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class BiorhythmCalculator extends StatefulWidget {
  @override
  _BiorhythmCalculatorState createState() => _BiorhythmCalculatorState();
}

class _BiorhythmCalculatorState extends State<BiorhythmCalculator> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _birthDateController = TextEditingController();
  late DateTime _birthDate;
  late DateTime _startDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Биоритмы'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextFormField(
              //   controller: _birthDateController,
              //   keyboardType: TextInputType.datetime,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Введите дату рождения';
              //     }
              //     return null;
              //   },
              //   decoration: const InputDecoration(
              //     filled: true,
              //     labelText: 'Дата рождения формата "YYYY-MM-DD"',
              //   ),
              // ),
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                child: TextFormField(
                  controller: _birthDateController,
                  keyboardType: TextInputType.datetime,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Введите дату рождения';
                  //   }
                  //   return null;
                  // },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    filled: true,
                    labelText: 'Дата рождения формата "YYYY-MM-DD"',
                    labelStyle: TextStyle(height: 6),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _birthDate = DateTime.parse(_birthDateController.text);
                        _startDate = DateTime.now();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BiorhythmChart(
                            birthDate: _birthDate,
                            startDate: _startDate,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Рассчитать'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BiorhythmChart extends StatefulWidget {
  final DateTime birthDate;
  final DateTime startDate;

  const BiorhythmChart({
    Key? key,
    required this.birthDate,
    required this.startDate,
  }) : super(key: key);

  @override
  _BiorhythmChartState createState() => _BiorhythmChartState();
}

class _BiorhythmChartState extends State<BiorhythmChart> {
  final _bioRhythms = {
    'Физический': (daysSinceBirth, j) =>
        sin(2 * pi * (daysSinceBirth + j) / 23),
    'Эмоциональный': (daysSinceBirth, j) =>
        sin(2 * pi * (daysSinceBirth + j) / 28),
    'Интеллектуальный': (daysSinceBirth, j) =>
        sin(2 * pi * (daysSinceBirth + j) / 33),
  };
  final _days = 30;
  List<List<double>> _values = [];

  void _calculateValues() {
    var daysSinceBirth = widget.startDate.difference(widget.birthDate).inDays;
    for (var i = 0; i < _bioRhythms.length; i++) {
      var bioRhythmValues = <double>[];
      for (var j = 0; j < _days; j++) {
        var value =
            _bioRhythms[_bioRhythms.keys.elementAt(i)]!(daysSinceBirth, j);
        bioRhythmValues.add(value);
      }
      _values.add(bioRhythmValues);
    }
  }

  @override
  void initState() {
    super.initState();
    if (_bioRhythms != null) {
      _calculateValues();
    }
  }

  GlobalKey _chartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Биоритмы'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < _bioRhythms.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _bioRhythms.keys.elementAt(i),
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 250.0,
                      child: LineChart(
                        LineChartData(
                          minX: 0,
                          maxX: _days.toDouble() - 1,
                          minY: -1,
                          maxY: 1,
                          lineBarsData: [
                            LineChartBarData(
                              spots: _values[i].asMap().entries.map((entry) {
                                var x = entry.key.toDouble();
                                var y = entry.value;
                                return FlSpot(x, y);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
