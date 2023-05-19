import 'dart:math';
import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Биологические ритмы – это регулярное и периодическое повторение во времени жизненных процессов или отдельных состояний.',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: TextFormField(
                  readOnly: true,
                  controller: _birthDateController,
                  keyboardType: TextInputType.datetime,
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        _birthDateController.text =
                            DateFormat('yyyy-MM-dd').format(date);
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.ru,
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите дату рождения';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Дата рождения',
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
