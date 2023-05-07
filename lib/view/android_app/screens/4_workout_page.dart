import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class workout_page extends StatelessWidget {
  const workout_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExercisePage(),
    );
  }
}

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExercisePage(),
    );
  }
}

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<dynamic> exerciseData = [];

  Future<void> getExerciseData() async {
    try {
      var response = await Dio().get('http://10.0.2.2:5000/exercise');
      if (response.statusCode == 200) {
        setState(() {
          exerciseData = response.data;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getExerciseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тренировки'),
        centerTitle: true,
      ),
      body: exerciseData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: getExerciseData,
              child: ListView.builder(
                itemCount: exerciseData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      if (index == 0 ||
                          exerciseData[index]['Person_workout'] !=
                              exerciseData[index - 1]['Person_workout'])
                        Container(
                          color: const Color.fromARGB(255, 154, 185, 201),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        exerciseData[index]['Person_workout'],
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 27, 94, 150),
                                            fontSize: 22),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${exerciseData[index]['Person_workout_Description']}'),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpansionTile(
                                title: Text(
                                  exerciseData[index]['Name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: const Color.fromARGB(
                                        255, 154, 185, 201),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(exerciseData[index]
                                        ['Exercise_category']),
                                    Text(
                                        'Сложность: ${exerciseData[index]['Load_score']}')
                                  ],
                                ),
                                children: [
                                  // ListTile(
                                  //   title: Text(
                                  //       'Exercise Plan Description: ${exerciseData[index]['Exercise_plan_Description']}'),
                                  // ),
                                  ListTile(
                                    title: Center(
                                      child: Text(
                                          '${exerciseData[index]['Number_of_repetitions']} повторений x ${exerciseData[index]['Number_of_approaches']}'),
                                    ),
                                    subtitle: Center(
                                      child: Text(
                                          'Время отдыха между подходами: ${exerciseData[index]['Rest_time']}'),
                                    ),
                                  ),

                                  ListTile(
                                    subtitle: Text(
                                        '${exerciseData[index]['Description']}'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
