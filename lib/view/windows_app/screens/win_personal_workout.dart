import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/models/user.dart';
import 'package:provider/provider.dart';
import '../../../models/service_category.dart';
import '../../../theme/theme.dart';

class personal_workout_page extends StatelessWidget {
  const personal_workout_page({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: PersonalWorkoutPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class PersonalWorkoutPage extends StatefulWidget {
  @override
  _PersonalWorkoutPageState createState() => _PersonalWorkoutPageState();
}

class _PersonalWorkoutPageState extends State<PersonalWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  List<dynamic> _categories = [];
  final _exercisePlanFormKey = GlobalKey<FormState>();
  final _exercisePlanScaffoldKey = GlobalKey<ScaffoldState>();
  final _exercisePlanNameController = TextEditingController();
  final _exercisePlanDescriptionController = TextEditingController();
  final _numRepetitionsController = TextEditingController();
  final _numApproachesController = TextEditingController();
  final _restTimeController = TextEditingController();
  final _dio = Dio();
  List<dynamic> _plans = [];
  List<Map<String, dynamic>> _personWorkouts = [];
  List<dynamic> exerciseData = [];

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
    _getCategories();
    _getPlans();
    _fetchPersonWorkouts();
    getExercises();
    getExerciseData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _exercisePlanNameController.dispose();
    _exercisePlanDescriptionController.dispose();
    _numRepetitionsController.dispose();
    _numApproachesController.dispose();
    _restTimeController.dispose();
    super.dispose();
  }

  Future<void> getExerciseData() async {
    try {
      var response = await Dio().get('http://localhost:5000/exercise');
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
      getExercises();
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
      getExercises();
    } catch (e) {
      print('Error: $e');
    }
  }

  void deleteExercise(int id) async {
    try {
      final response = await dio.delete('http://localhost:5000/exercise/$id');
      print(response.data);
      getExercises();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchPersonWorkouts() async {
    try {
      final response = await _dio.get('http://localhost:5000/person_workouts');
      final data = response.data as List<dynamic>;
      setState(() {
        _personWorkouts = data.cast<Map<String, dynamic>>();
      });
    } catch (error) {
      print('Error fetching person workouts: $error');
    }
  }

  Future<void> _addPersonWorkout(
      String name, String description, int userId) async {
    try {
      final response =
          await _dio.post('http://localhost:5000/person_workout', data: {
        'name': name,
        'description': description,
        'user_id': User.get().id,
      });
      final message = response.data['message'];
      print(message);
      _fetchPersonWorkouts();
    } catch (error) {
      print('Error adding person workout: $error');
    }
  }

  Future<void> _updatePersonWorkout(
      int id, String name, String description, int userId) async {
    try {
      final response =
          await _dio.put('http://localhost:5000/person_workout/$id', data: {
        'name': name,
        'description': description,
        'user_id': User.get().id,
      });
      final message = response.data['message'];
      print(message);
      _fetchPersonWorkouts();
    } catch (error) {
      print('Error updating person workout: $error');
    }
  }

  Future<void> _deletePersonWorkout(int id) async {
    try {
      final response =
          await _dio.delete('http://localhost:5000/person_workout/$id');
      final message = response.data['message'];
      print(message);
      _fetchPersonWorkouts();
    } catch (error) {
      print('Error deleting person workout: $error');
    }
  }

  void _getPlans() async {
    try {
      final response = await _dio.get('http://localhost:5000/exercise_plans');
      setState(() {
        _plans = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  void _addPlan() async {
    try {
      final response =
          await _dio.post('http://localhost:5000/exercise_plan', data: {
        'name': _exercisePlanNameController.text,
        'description': _exercisePlanDescriptionController.text,
        'number_of_repetitions': _numRepetitionsController.text,
        'number_of_approaches': _numApproachesController.text,
        'rest_time': _restTimeController.text,
      });

      _getPlans();
    } catch (e) {
      print(e);
    }
  }

  void _updatePlan(int id) async {
    try {
      final response =
          await _dio.put('http://localhost:5000/exercise_plan/$id', data: {
        'name': _exercisePlanNameController.text,
        'description': _exercisePlanDescriptionController.text,
        'number_of_repetitions': _numRepetitionsController.text,
        'number_of_approaches': _numApproachesController.text,
        'rest_time': _restTimeController.text,
      });
      _getPlans();
    } catch (e) {
      print(e);
    }
  }

  void _deletePlan(int id) async {
    try {
      final response =
          await _dio.delete('http://localhost:5000/exercise_plan/$id');

      _getPlans();
    } catch (e) {
      print(e);
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Добавить план тренировок'),
          content: Form(
            key: _exercisePlanFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _exercisePlanNameController,
                  decoration: const InputDecoration(labelText: 'Название'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите название';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _exercisePlanDescriptionController,
                  decoration: const InputDecoration(labelText: 'Описание'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите описание';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _numRepetitionsController,
                  decoration:
                      const InputDecoration(labelText: 'Количество повторений'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите количество повторений';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _numApproachesController,
                  decoration:
                      const InputDecoration(labelText: 'Количество подходов'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите количество подходов';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _restTimeController,
                  decoration: const InputDecoration(labelText: 'Время отдыха'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите время отдыха';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            OutlinedButton(
              onPressed: () {
                if (_exercisePlanFormKey.currentState!.validate()) {
                  _addPlan();
                  Navigator.pop(context);
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(dynamic plan) {
    _exercisePlanNameController.text = plan['Name'];
    _exercisePlanDescriptionController.text = plan['Description'];
    _numRepetitionsController.text = plan['Number_of_repetitions'].toString();
    _numApproachesController.text = plan['Number_of_approaches'].toString();
    _restTimeController.text = plan['Rest_time'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Изменить план тренировок'),
          content: Form(
            key: _exercisePlanFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _exercisePlanNameController,
                  decoration: const InputDecoration(labelText: 'Название'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите название';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _exercisePlanDescriptionController,
                  decoration: const InputDecoration(labelText: 'Описание'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите описание';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _numRepetitionsController,
                  decoration:
                      const InputDecoration(labelText: 'Количество повторений'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите количество повторений';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _numApproachesController,
                  decoration:
                      const InputDecoration(labelText: 'Количество подходов'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите количество подходов';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _restTimeController,
                  decoration: const InputDecoration(labelText: 'Время отдыха'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите время отдыха';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            OutlinedButton(
              onPressed: () {
                if (_exercisePlanFormKey.currentState!.validate()) {
                  _updatePlan(plan['ID_Exercise_plan']);
                  Navigator.pop(context);
                }
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(dynamic plan) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Удалить план тренировок'),
          content:
              Text('Вы уверены, что хотите удалить план "${plan['Name']}"?'),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            OutlinedButton(
              onPressed: () {
                _deletePlan(plan['ID_Exercise_plan']);
                Navigator.pop(context);
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getCategories() async {
    try {
      final response =
          await Dio().get('http://localhost:5000/exercise_categories');
      setState(() {
        _categories = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addCategory(String name) async {
    try {
      final response = await Dio().post(
          'http://localhost:5000/exercise_category',
          data: {'name': name});

      _getCategories();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateCategory(int id, String name) async {
    try {
      final response = await Dio().put(
          'http://localhost:5000/exercise_category/$id',
          data: {'name': name});

      _getCategories();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteCategory(int id) async {
    try {
      final response =
          await Dio().delete('http://localhost:5000/exercise_category/$id');

      _getCategories();
    } catch (e) {
      print(e);
    }
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить категорию упражнения'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Введите название категории';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Название категории',
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
          OutlinedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _addCategory(_nameController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _showEditCategoryDialog(int id, String name) {
    _idController.text = id.toString();
    _nameController.text = name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Изменить категорию упражнения'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Введите название категории';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Название категории',
                ),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
          OutlinedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _updateCategory(
                    int.parse(_idController.text), _nameController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showDeleteCategoryDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить категорию упражнения'),
        content: const Text(
            'Вы уверены, что хотите удалить эту категорию упражнения?'),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
          OutlinedButton(
            onPressed: () {
              _deleteCategory(id);
              Navigator.pop(context);
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тренировки'),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Colors.blueGrey[100],
                child: Stack(
                  children: [
                    ListView.builder(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              exerciseData[index]
                                                  ['Person_workout'],
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
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(exerciseData[index]
                                              ['Exercise_category']),
                                          Text(
                                              'Сложность: ${exerciseData[index]['Load_score']}'),
                                        ],
                                      ),
                                      children: [
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Добавить упражнение'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller:
                                                  exerciseNameController,
                                              decoration: const InputDecoration(
                                                  labelText: 'Название'),
                                            ),
                                            TextField(
                                              controller:
                                                  exerciseDescriptionController,
                                              decoration: const InputDecoration(
                                                  labelText: 'Описание'),
                                            ),
                                            TextField(
                                              controller: loadScoreController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'Степень нагрузки'),
                                            ),
                                            TextField(
                                              controller:
                                                  exerciseCategoryIdController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  labelText: 'Код упражнения'),
                                            ),
                                            TextField(
                                              controller:
                                                  exercisePlanIdController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'Код плана упражнения'),
                                            ),
                                            TextField(
                                              controller:
                                                  personWorkoutIdController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  labelText: 'Код тренировки'),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text('Отмена'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Добавить'),
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
                                child: const Text('Добавить упражнение'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: _plans.length,
                            itemBuilder: (context, index) {
                              final plan = _plans[index];
                              return Card(
                                child: ListTile(
                                  title: Text(plan['Name']),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(plan['Description']),
                                      Text('Код плана упражнения: ' +
                                          plan['ID_Exercise_plan'].toString()),
                                    ],
                                  ),
                                  onTap: () {
                                    _showEditDialog(plan);
                                  },
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          _showDeleteDialog(plan);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    onPressed: _showAddDialog,
                                    child:
                                        const Text('Добавить план упражнения'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        ListView.builder(
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            final category = _categories[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  title: Text(category['Name']),
                                  subtitle: Text('Код категории упражнения: ' +
                                      category['ID_Exercise_category']
                                          .toString()),
                                  onTap: () {
                                    _showEditCategoryDialog(
                                        category['ID_Exercise_category'],
                                        category['Name']);
                                  },
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          _showDeleteCategoryDialog(
                                              category['ID_Exercise_category']);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      _showAddCategoryDialog();
                                    },
                                    child: const Text(
                                        'Добавить категорию упражнения'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: _personWorkouts.length,
                              itemBuilder: (context, index) {
                                final personWorkout = _personWorkouts[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(personWorkout['Name']),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(personWorkout['Description']),
                                        Text('Код личной тренировки: ' +
                                            personWorkout['ID_Person_workout']
                                                .toString()),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _deletePersonWorkout(
                                          personWorkout['ID_Person_workout']),
                                    ),
                                    onTap: () =>
                                        _showEditDialog2(personWorkout),
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      onPressed: () => _showAddDialog2(),
                                      child: const Text(
                                          'Добавить личную тренировку'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddDialog2() async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final userIdController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Добавить тренировку'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              child: const Text('Отмена'),
              onPressed: () => Navigator.pop(context),
            ),
            OutlinedButton(
              child: const Text('Добавить'),
              onPressed: () {
                final name = nameController.text;
                final description = descriptionController.text;
                final userId = int.tryParse(userIdController.text) ?? 0;
                _addPersonWorkout(name, description, userId);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDialog2(Map<String, dynamic> personWorkout) async {
    final nameController = TextEditingController(text: personWorkout['Name']);
    final descriptionController =
        TextEditingController(text: personWorkout['Description']);
    final userIdController =
        TextEditingController(text: personWorkout['User_id'].toString());

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Изменить'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              child: const Text('Отмена'),
              onPressed: () => Navigator.pop(context),
            ),
            OutlinedButton(
              child: const Text('Изменить'),
              onPressed: () {
                final id = personWorkout['ID_Person_workout'];
                final name = nameController.text;
                final description = descriptionController.text;
                final userId = int.tryParse(userIdController.text) ?? 0;
                _updatePersonWorkout(id, name, description, userId);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
