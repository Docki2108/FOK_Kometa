import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SleepCycleCalculator extends StatefulWidget {
  @override
  _SleepCycleCalculatorState createState() => _SleepCycleCalculatorState();
}

class _SleepCycleCalculatorState extends State<SleepCycleCalculator> {
  final _sleepTimeController = TextEditingController();
  final _wakeUpTimeController = TextEditingController();
  String _sleepAtTime = '';
  String _wakeUpAtTime = '';

  Future<void> _selectSleepTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      _sleepTimeController.text = DateFormat('HH:mm').format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      ));
    }
  }

  Future<void> _selectWakeUpTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      _wakeUpTimeController.text = DateFormat('HH:mm').format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      ));
    }
  }

  void _calculateSleepAtTime() {
    final wakeUpTime = DateFormat('HH:mm').parse(_wakeUpTimeController.text);

    setState(() {
      _sleepAtTime = '';
    });

    for (int i = 0; i < 6; i++) {
      final duration = Duration(minutes: 90 * (i + 1));
      final sleepAtTime =
          DateFormat('HH:mm').format(wakeUpTime.subtract(duration));

      setState(() {
        _sleepAtTime += '$sleepAtTime\n';
      });
    }
  }

  void _calculateWakeUpTime() {
    final sleepTime = DateFormat('HH:mm').parse(_sleepTimeController.text);

    setState(() {
      _wakeUpAtTime = '';
    });

    for (int i = 0; i < 6; i++) {
      final duration = Duration(minutes: 90 * (i + 1));
      final wakeUpAtTime = DateFormat('HH:mm').format(sleepTime.add(duration));

      setState(() {
        _wakeUpAtTime += '$wakeUpAtTime\n';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расчет сна'),
        centerTitle: true,
        elevation: 3,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _sleepTimeController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Время засыпания',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                      ),
                                      onPressed: () =>
                                          _selectSleepTime(context),
                                      child: const Text('Выбрать'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 250,
                                      child: Text(
                                        _wakeUpAtTime != ''
                                            ? 'Чтобы быть бодрым, нужно встать в:'
                                            : '',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _wakeUpAtTime,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                              ),
                              onPressed: () => _calculateWakeUpTime(),
                              child: const Text('Рассчитать время подъема'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _wakeUpTimeController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Время подъема',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                      ),
                                      onPressed: () =>
                                          _selectWakeUpTime(context),
                                      child: const Text('Выбрать'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 250,
                                      child: Text(
                                        _sleepAtTime != ''
                                            ? 'Чтобы быть бодрым, нужно заснуть в:'
                                            : '',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _sleepAtTime,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                              ),
                              onPressed: () => _calculateSleepAtTime(),
                              child: const Text('Рассчитать время засыпания'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
