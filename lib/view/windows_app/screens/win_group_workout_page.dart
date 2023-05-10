import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fok_kometa/new_models/user.dart';
import 'package:provider/provider.dart';
import '../../../new_models/group_workout_category.dart';
import '../../../new_models/service_category.dart';
import '../../../theme/theme.dart';
import 'package:intl/intl.dart';

class win_group_workout_page extends StatelessWidget {
  const win_group_workout_page({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: GroupWorkoutCategoriesScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class GroupWorkoutCategoryApi {
  final Dio _dio = Dio();

  Future<List<GroupWorkoutCategory>> getGroupWorkoutCategories() async {
    try {
      final response =
          await _dio.get('http://localhost:5000/group_workout_categories');
      final data = response.data as List<dynamic>;
      final categories = data
          .map((category) => GroupWorkoutCategory.fromJson(category))
          .toList();
      return categories;
    } catch (error) {
      throw Exception('Failed to load group workout categories');
    }
  }

  Future<void> addGroupWorkoutCategory(String name) async {
    try {
      final data = {'name': name};
      await _dio.post('http://localhost:5000/group_workout_category',
          data: data);
    } catch (error) {
      throw Exception('Failed to add group workout category');
    }
  }

  Future<void> updateGroupWorkoutCategory(int id, String name) async {
    try {
      final response = await _dio.put(
          'http://localhost:5000/group_workout_category/$id',
          data: {'name': name});
      if (response.statusCode == 200) {
        final message = response.data['message'];
        print(message);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deleteGroupWorkoutCategory(int id) async {
    try {
      await _dio.delete('http://localhost:5000/group_workout_category/$id');
    } catch (error) {
      throw Exception('Failed to delete group workout category');
    }
  }
}

class GroupWorkoutCategoriesScreen extends StatefulWidget {
  @override
  _GroupWorkoutCategoriesScreenState createState() =>
      _GroupWorkoutCategoriesScreenState();
}

class _GroupWorkoutCategoriesScreenState
    extends State<GroupWorkoutCategoriesScreen> {
  final GroupWorkoutCategoryApi _api = GroupWorkoutCategoryApi();
  List<GroupWorkoutCategory> _categories = [];
  bool _isLoading = false;
  final String apiUrl = 'http://localhost:5000/group_workouts';
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController loadScoreController = TextEditingController();
  final TextEditingController recommendedAgeController =
      TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController coachController = TextEditingController();
  final Dio dio = Dio();
  List<dynamic> groupWorkouts = [];
  DateTime? selectedDate;
  DateTime selectedStartTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    _loadGroupWorkoutCategories();
    getGroupWorkouts();
  }

  Future<void> getGroupWorkouts() async {
    try {
      final response = await dio.get(apiUrl);
      setState(() {
        groupWorkouts = response.data['group_workouts'];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addGroupWorkout() async {
    try {
      final response = await dio.post(apiUrl, data: {
        'event_date': eventDateController.text,
        'start_time': startTimeController.text,
        'end_time': endTimeController.text,
        'name': nameController.text,
        'description': descriptionController.text,
        'load_score': loadScoreController.text,
        'recommended_age': recommendedAgeController.text,
        'group_workout_category_id': categoryController.text,
        'coach_id': coachController.text,
        'user_id': User.get().id,
      });
      clearTextFields();
      getGroupWorkouts();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateGroupWorkout(dynamic groupWorkout) async {
    try {
      final response = await dio.put('$apiUrl/${groupWorkout['id']}', data: {
        'event_date': eventDateController.text,
        'start_time': startTimeController.text,
        'end_time': endTimeController.text,
        'name': nameController.text,
        'description': descriptionController.text,
        'load_score': loadScoreController.text,
        'recommended_age': recommendedAgeController.text,
        'group_workout_category_id': categoryController.text,
        'coach_id': coachController.text,
        'user_id': User.get().id,
      });
      clearTextFields();
      getGroupWorkouts();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteGroupWorkout(dynamic groupWorkout) async {
    try {
      final response = await dio.delete('$apiUrl/${groupWorkout['id']}');
      getGroupWorkouts();
    } catch (e) {
      print(e);
    }
  }

  void clearTextFields() {
    eventDateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    nameController.clear();
    descriptionController.clear();
    loadScoreController.clear();
    recommendedAgeController.clear();
    categoryController.clear();
    coachController.clear();
  }

  Future<void> _loadGroupWorkoutCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final categories = await _api.getGroupWorkoutCategories();
      setState(() {
        _categories = categories;
      });
    } catch (error) {
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addGroupWorkoutCategory(String name) async {
    try {
      await _api.addGroupWorkoutCategory(name);
      _loadGroupWorkoutCategories();
    } catch (error) {}
  }

  Future<void> _updateGroupWorkoutCategory(int id, String newName) async {
    try {
      await _api.updateGroupWorkoutCategory(id, newName);
      _loadGroupWorkoutCategories();
    } catch (error) {}
  }

  Future<void> _deleteGroupWorkoutCategory(int id) async {
    try {
      await _api.deleteGroupWorkoutCategory(id);
      _loadGroupWorkoutCategories();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Групповые тренировки'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey[100],
              child: ListView.builder(
                itemCount: groupWorkouts.length,
                itemBuilder: (context, index) {
                  final groupWorkout = groupWorkouts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(groupWorkout['name']),
                        subtitle: Text('Дата: ${groupWorkout['event_date']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteGroupWorkout(groupWorkout);
                          },
                        ),
                        onTap: () {
                          eventDateController.text = groupWorkout['event_date'];
                          startTimeController.text = groupWorkout['start_time'];
                          endTimeController.text = groupWorkout['end_time'];
                          nameController.text = groupWorkout['name'];
                          descriptionController.text =
                              groupWorkout['description'];
                          loadScoreController.text =
                              groupWorkout['load_score'].toString();
                          recommendedAgeController.text =
                              groupWorkout['recommended_age'].toString();
                          categoryController.text =
                              groupWorkout['group_workout_category'];
                          coachController.text = groupWorkout['coach'];

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    Text('Редактировать групповую тренировку'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: eventDateController,
                                        decoration: InputDecoration(
                                            labelText: 'Дата (дд.мм.гггг)'),
                                      ),
                                      TextField(
                                        controller: startTimeController,
                                        decoration: InputDecoration(
                                            labelText: 'Время начала (чч:мм)'),
                                      ),
                                      TextField(
                                        controller: endTimeController,
                                        decoration: InputDecoration(
                                            labelText:
                                                'Время окончания (чч:мм)'),
                                      ),
                                      TextField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                            labelText: 'Название'),
                                      ),
                                      TextField(
                                        controller: descriptionController,
                                        decoration: InputDecoration(
                                            labelText: 'Описание'),
                                      ),
                                      TextField(
                                        controller: loadScoreController,
                                        decoration: InputDecoration(
                                            labelText: 'Оценка нагрузки'),
                                      ),
                                      TextField(
                                        controller: recommendedAgeController,
                                        decoration: InputDecoration(
                                            labelText: 'Рекомендуемый возраст'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      clearTextFields();
                                      Navigator.pop(context);
                                    },
                                    child: Text('Отмена'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      updateGroupWorkout(groupWorkout);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Сохранить'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Card(
                            color: Colors.blueGrey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          DatePicker.showDatePicker(
                                            context,
                                            showTitleActions: true,
                                            minTime: DateTime(2021, 1, 1),
                                            maxTime: DateTime(2025, 12, 31),
                                            onChanged: (date) {},
                                            onConfirm: (date) {
                                              setState(() {
                                                selectedDate = date;
                                                eventDateController.text =
                                                    DateFormat('dd.MM.yyyy')
                                                        .format(date);
                                              });
                                            },
                                            currentTime:
                                                selectedDate ?? DateTime.now(),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 16.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            border: Border.all(
                                              color: Colors.grey[400]!,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                selectedDate != null
                                                    ? DateFormat('dd.MM.yyyy')
                                                        .format(selectedDate!)
                                                    : 'Выбрать дату проведения',
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                              Icon(Icons.calendar_today),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 8, 8),
                                          child: TextField(
                                            controller: startTimeController,
                                            maxLength: 5,
                                            decoration: InputDecoration(
                                                filled: true,
                                                labelText:
                                                    'Время начала (чч:мм)'),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 0, 8),
                                          child: TextField(
                                            controller: endTimeController,
                                            maxLength: 5,
                                            decoration: InputDecoration(
                                                filled: true,
                                                labelText:
                                                    'Время окончания (чч:мм)'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextField(
                                    controller: nameController,
                                    maxLength: 100,
                                    decoration: InputDecoration(
                                        filled: true, labelText: 'Название'),
                                  ),
                                  TextField(
                                    controller: descriptionController,
                                    maxLength: 300,
                                    decoration: InputDecoration(
                                        filled: true, labelText: 'Описание'),
                                  ),
                                  TextField(
                                    controller: loadScoreController,
                                    maxLength: 3,
                                    decoration: InputDecoration(
                                        filled: true,
                                        labelText: 'Оценка нагрузки'),
                                  ),
                                  TextField(
                                    controller: recommendedAgeController,
                                    maxLength: 3,
                                    decoration: InputDecoration(
                                        filled: true,
                                        labelText: 'Рекомендуемый возраст'),
                                  ),
                                  TextField(
                                    controller: categoryController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        labelText: 'Категория тренировки'),
                                  ),
                                  TextField(
                                    controller: coachController,
                                    decoration: InputDecoration(
                                        filled: true, labelText: 'Тренер'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: _categories.length,
                              itemBuilder: (context, index) {
                                final category = _categories[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(category.name),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () =>
                                            _deleteGroupWorkoutCategory(
                                                category.id),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            final nameController =
                                                TextEditingController(
                                                    text: category.name);
                                            return AlertDialog(
                                              title: const Text(
                                                  'Изменить категорию'),
                                              content: TextField(
                                                controller: nameController,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Название',
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Отмена'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Изменить'),
                                                  onPressed: () {
                                                    final newName =
                                                        nameController.text;
                                                    _updateGroupWorkoutCategory(
                                                        category.id, newName);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final nameController = TextEditingController();
              return AlertDialog(
                title: const Text('Добавить категорию'),
                content: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Название',
                  ),
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
                      final name = nameController.text;
                      _addGroupWorkoutCategory(name);
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
