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

  void _calculateSleep() {
    final sleepTime = DateFormat('HH:mm').parse(_sleepTimeController.text);
    final wakeUpTime = DateFormat('HH:mm').parse(_wakeUpTimeController.text);

    for (int i = 0; i < 6; i++) {
      final duration = Duration(hours: i + 1, minutes: 30);
      final sleepAtTime =
          DateFormat('HH:mm').format(wakeUpTime.subtract(duration));
      final wakeUpAtTime = DateFormat('HH:mm').format(sleepTime.add(duration));

      setState(() {
        _sleepAtTime += '$sleepAtTime\n';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _selectSleepTime(context),
              child: Text('Select Sleep Time'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _sleepTimeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Sleep Time',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _selectWakeUpTime(context),
              child: Text('Select Wake Up Time'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _wakeUpTimeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Wake Up Time',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _calculateSleep(),
              child: Text('Calculate Sleep Cycles'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Sleep At:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              _sleepAtTime,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Wake Up At:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              _wakeUpAtTime,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
