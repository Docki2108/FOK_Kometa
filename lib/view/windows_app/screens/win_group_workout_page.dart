import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fok_kometa/new_models/user.dart';
import 'package:fok_kometa/stuffs/constant.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dio = Dio();
  List<dynamic> _groupWorkouts = [];
  bool _isEditing = false;
  int? _selectedId;
  List<dynamic> _coaches = [];

  TextEditingController _eventDateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _loadScoreController = TextEditingController();
  TextEditingController _recommendedAgeController = TextEditingController();
  TextEditingController _groupWorkoutCategoryIdController =
      TextEditingController();
  TextEditingController _coachIdController = TextEditingController();
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
  int? _selectedCategoryId;
  List<dynamic> categories = [];

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

  Future<void> _getCategories() async {
    try {
      final response =
          await Dio().get('http://localhost:5000/group_workout_categories');

      setState(() {
        categories = response.data;
      });
    } catch (e) {
      throw Exception('Failed to load categories');
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

  Future<void> _deleteGroupWorkout(int id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _dio.delete('http://localhost:5000/group_workout/$id');
      setState(() {
        _isLoading = false;
        getGroupWorkouts();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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

  Future<void> updateGroupWorkoutCategory(int id, String name) async {
    try {
      final response = await Dio().put(
          'http://localhost:5000/group_workout_category/$id',
          data: {'name': name});
      if (response.statusCode == 200) {
        final message = response.data['message'];
        print(message);
        _loadGroupWorkoutCategories();
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _addOrUpdateGroupWorkout() async {
    setState(() {
      _isLoading = true;
    });
    final data = {
      'event_date': _eventDateController.text,
      'start_time': _startTimeController.text,
      'end_time': _endTimeController.text,
      'name': _nameController.text,
      'description': _descriptionController.text,
      'load_score': int.parse(_loadScoreController.text),
      'recommended_age': int.parse(_recommendedAgeController.text),
      'group_workout_category_id':
          int.parse(_groupWorkoutCategoryIdController.text),
      'coach_id': int.parse(_coachIdController.text),
      'user_id': User.get().id,
    };
    try {
      await _dio.post('http://localhost:5000/group_workout', data: data);

      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
      getGroupWorkouts();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
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
        actions: [
          IconButton(
            onPressed: () {
              _loadGroupWorkoutCategories();
              getGroupWorkouts();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
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
                        title: Column(
                          children: [
                            Text(groupWorkout['name']),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Text('Дата: ${groupWorkout['event_date']}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Время начала: ' +
                                    groupWorkout['start_time'].substring(0, 5)),
                                Text(' '),
                                Text('Время окончания: ' +
                                    groupWorkout['end_time'].substring(0, 5)),
                              ],
                            ),
                            Text('Описание: ${groupWorkout['description']}'),
                            Text('Нагрузка: ${groupWorkout['load_score']}'),
                            Text(
                                'Категория: ${groupWorkout['group_workout_category']}'),
                            Text('Тренер: ${groupWorkout['coach']}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteGroupWorkout(groupWorkout['id']);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.blueGrey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                      child: TextFormField(
                                        inputFormatters: [maskDate],
                                        controller: _eventDateController,
                                        maxLines: 5,
                                        minLines: 1,
                                        maxLength: 10,
                                        decoration: InputDecoration(
                                            filled: true,
                                            labelText: 'Дата события'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Введите дату!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                      child: TextFormField(
                                        inputFormatters: [maskTime],
                                        minLines: 1,
                                        maxLength: 5,
                                        controller: _startTimeController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            labelText: 'Время начала'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                      child: TextFormField(
                                        inputFormatters: [maskTime],
                                        minLines: 1,
                                        maxLength: 5,
                                        controller: _endTimeController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            labelText: 'Время окончания'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                maxLines: 5,
                                minLines: 1,
                                maxLength: 50,
                                controller: _nameController,
                                decoration: InputDecoration(
                                    filled: true, labelText: 'Название'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter name';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                maxLines: 5,
                                minLines: 1,
                                maxLength: 50,
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                    filled: true, labelText: 'Описание'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Заполните поле!';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                      child: TextFormField(
                                        minLines: 1,
                                        maxLength: 2,
                                        controller: _loadScoreController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            labelText: 'Нагрузка'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Заполните поле!';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Только числа!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                      child: TextFormField(
                                        maxLength: 2,
                                        controller: _recommendedAgeController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            labelText: 'Рекомендуемый возраст'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Заполните поле!';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Только числа!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                      child:
                                          // DropdownButtonFormField(
                                          //   value: _selectedCategoryId,
                                          //   onChanged: (value) {
                                          //     setState(() {
                                          //       _selectedCategoryId = value as int?;
                                          //     });
                                          //   },
                                          //   items: categories.map((category) {
                                          //     return DropdownMenuItem(
                                          //       value: category[
                                          //           'ID_Group_workout_category'],
                                          //       child: Text(category['Name']),
                                          //     );
                                          //   }).toList(),
                                          //   decoration: InputDecoration(
                                          //     labelText: 'Category',
                                          //     border: OutlineInputBorder(),
                                          //   ),
                                          // ),
                                          TextFormField(
                                        maxLength: 3,
                                        controller:
                                            _groupWorkoutCategoryIdController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            labelText: 'Код категории'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Заполните поле!';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Только числа!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                      child: TextFormField(
                                        maxLength: 3,
                                        controller: _coachIdController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            labelText:
                                                'Индивидуальный код тренера'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Заполните поле!';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Только числа!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _addOrUpdateGroupWorkout();
                                },
                                child:
                                    Text(_isEditing ? 'Добавить' : 'Добавить'),
                              ),
                            ],
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
                                    subtitle: Text('Код категории: ' +
                                        category.id.toString()),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                          _deleteGroupWorkoutCategory(
                                              category.id),
                                    ),
                                    // onTap: () {},
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
