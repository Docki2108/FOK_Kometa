import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/new_models/user.dart';
import 'package:provider/provider.dart';
import '../../../new_models/diet_category.dart';
import '../../../new_models/person_workout.dart';
import '../../../new_models/service_category.dart';
import '../../../theme/theme.dart';

class win_test extends StatelessWidget {
  const win_test({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: ExercisePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<dynamic> exercises = [];
  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController exerciseDescriptionController = TextEditingController();
  TextEditingController loadScoreController = TextEditingController();
  TextEditingController exerciseCategoryIdController = TextEditingController();
  TextEditingController exercisePlanIdController = TextEditingController();
  TextEditingController personWorkoutIdController = TextEditingController();

  final dio = Dio();

  @override
  void initState() {
    super.initState();
    getExercises();
  }

  void getExercises() async {
    try {
      final response = await dio.get('http://localhost:5000/exercise');
      setState(() {
        exercises = response.data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void addExercise() async {
    try {
      final response = await dio.post('http://localhost:5000/exercise', data: {
        'name': exerciseNameController.text,
        'description': exerciseDescriptionController.text,
        'load_score': int.parse(loadScoreController.text),
        'exercise_category_id': int.parse(exerciseCategoryIdController.text),
        'exercise_plan_id': int.parse(exercisePlanIdController.text),
        'person_workout_id': int.parse(personWorkoutIdController.text),
      });
      print(response.data);
      getExercises(); // Refresh the exercises list
    } catch (e) {
      print('Error: $e');
    }
  }

  void updateExercise(int id, String name, String description, int loadScore,
      int exerciseCategoryId, int exercisePlanId, int personWorkoutId) async {
    try {
      final response =
          await dio.put('http://localhost:5000/exercise/$id', data: {
        'name': name,
        'description': description,
        'load_score': loadScore,
        'exercise_category_id': exerciseCategoryId,
        'exercise_plan_id': exercisePlanId,
        'person_workout_id': personWorkoutId,
      });
      print(response.data);
      getExercises(); // Refresh the exercises list
    } catch (e) {
      print('Error: $e');
    }
  }

  void deleteExercise(int id) async {
    try {
      final response = await dio.delete('http://localhost:5000/exercise/$id');
      print(response.data);
      getExercises(); // Refresh the exercises list
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Page'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          var exercise = exercises[index];
          return ListTile(
            title: Text(exercise['Name']),
            subtitle: Text(exercise['Description']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteExercise(exercise['ID_Exercise']);
              },
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Edit Exercise'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: exerciseNameController,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                        TextField(
                          controller: exerciseDescriptionController,
                          decoration: InputDecoration(labelText: 'Description'),
                        ),
                        TextField(
                          controller: loadScoreController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Load Score'),
                        ),
                        TextField(
                          controller: exerciseCategoryIdController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Exercise Category ID'),
                        ),
                        TextField(
                          controller: exercisePlanIdController,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Exercise Plan ID'),
                        ),
                        TextField(
                          controller: personWorkoutIdController,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Person Workout ID'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Update'),
                        onPressed: () {
                          updateExercise(
                            exercise['ID_Exercise'],
                            exerciseNameController.text,
                            exerciseDescriptionController.text,
                            int.parse(loadScoreController.text),
                            int.parse(exerciseCategoryIdController.text),
                            int.parse(exercisePlanIdController.text),
                            int.parse(personWorkoutIdController.text),
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Exercise'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: exerciseNameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: exerciseDescriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    TextField(
                      controller: loadScoreController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Load Score'),
                    ),
                    TextField(
                      controller: exerciseCategoryIdController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: 'Exercise Category ID'),
                    ),
                    TextField(
                      controller: exercisePlanIdController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: 'Exercise Plan ID'),
                    ),
                    TextField(
                      controller: personWorkoutIdController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: 'Person Workout ID'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      addExercise();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
