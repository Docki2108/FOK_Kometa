import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../hive/weight_model.dart';
import '../../../../new_models/user.dart';
import '../../../../services/hive_weight.dart';
import '../../../../theme/theme.dart';
import 'package:fok_kometa/l10n/ru.dart';
import 'package:intl/intl.dart';

class weight_calendar_page extends StatelessWidget {
  const weight_calendar_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: WeightCalendar(
            User.get().email,
          ),
        );
      }),
    );
  }
}

class WeightCalendar extends StatefulWidget {
  final String email;

  WeightCalendar(this.email);

  @override
  _WeightCalendarState createState() => _WeightCalendarState();
}

class _WeightCalendarState extends State<WeightCalendar> {
  late TextEditingController _weightController;
  List<Weight> _weights = [];

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
    _loadWeights();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _loadWeights() async {
    final weights = await HiveService.getWeights(widget.email);
    setState(() {
      _weights = weights;
    });
  }

  void _addWeight(double weight) async {
    final now = DateTime.now().toUtc().add(const Duration(hours: 5));
    final date = DateTime(now.year, now.month, now.day);
    final newWeight = Weight(date, weight);
    await HiveService.addWeight(widget.email, newWeight);
    setState(() {
      _weights.add(newWeight);
    });
  }

  void _deleteWeight(int index) async {
    final weight = _weights[index];
    await HiveService.deleteWeight(widget.email, weight);
    setState(() {
      _weights.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('График веса'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat('dd MMMM', 'ru'),
                    intervalType: DateTimeIntervalType.days,
                  ),
                  series: <ChartSeries>[
                    LineSeries<Weight, DateTime>(
                      dataSource: _weights,
                      xValueMapper: (Weight weight, _) => weight.date,
                      yValueMapper: (Weight weight, _) => weight.weight,
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: WeightChart(weights: _weights),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: _weights.length,
                itemBuilder: (context, index) {
                  final weight = _weights[index];
                  return Card(
                    child: ListTile(
                      title: Text('Дата: ' +
                          '0' +
                          '${weight.date.day}.' +
                          '0' +
                          '${weight.date.month}.' +
                          '${weight.date.year}'),
                      subtitle: Text('Вес: ' + '${weight.weight} кг'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Center(
                                child: Text(
                                  'Внимание',
                                ),
                              ),
                              content: const Text(
                                'Вы уверены, что хотите удалить запись?',
                                style: TextStyle(fontSize: 16),
                              ),
                              actions: <Widget>[
                                OutlinedButton(
                                  style: const ButtonStyle(),
                                  onPressed: () async {
                                    _deleteWeight(index);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: const Text(
                                    'ДА',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: const Text(
                                    'НЕТ',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        color: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Добавить вес'),
                content: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Введите свой вес в кг',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Отмена'),
                  ),
                  TextButton(
                    onPressed: () {
                      final weight = double.tryParse(_weightController.text);
                      if (weight != null) {
                        _addWeight(weight);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Добавить'),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
