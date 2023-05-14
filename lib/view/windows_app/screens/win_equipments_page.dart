import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../new_models/news.dart';
import '../../../new_models/news_category.dart';
import '../../../theme/theme.dart';

class win_equipments_page extends StatelessWidget {
  const win_equipments_page({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: ExerciseEquipmentCategoryPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class ExerciseEquipmentCategoryPage extends StatefulWidget {
  @override
  _ExerciseEquipmentCategoryPageState createState() =>
      _ExerciseEquipmentCategoryPageState();
}

class _ExerciseEquipmentCategoryPageState
    extends State<ExerciseEquipmentCategoryPage> {
  List<dynamic> categories = [];
  List<dynamic> equipment = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int? selectedCategoryId;

  Future<void> _getCategories() async {
    try {
      final response =
          await Dio().get('http://localhost:5000/exercise_equipment_category');

      setState(() {
        categories = response.data;
      });
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> _createCategory(String name) async {
    try {
      final response = await Dio().post(
        'http://localhost:5000/exercise_equipment_category',
        data: {'Name': name},
      );

      _getCategories();
    } catch (e) {
      throw Exception('Ошибка в добавлении');
    }
  }

  Future<void> _updateCategory(int id, String name) async {
    try {
      final response = await Dio().put(
        'http://localhost:5000/exercise_equipment_category/$id',
        data: {'Name': name},
      );

      _getCategories();
    } catch (e) {
      throw Exception('Ошибка в изменении');
    }
  }

  Future<void> _deleteCategory(int id) async {
    try {
      final response = await Dio().delete(
        'http://localhost:5000/exercise_equipment_category/$id',
      );

      _getCategories();
    } catch (e) {
      throw Exception('Ошибка в удалении');
    }
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
    _getEquipment();
  }

  Future<void> _getEquipment() async {
    try {
      final response =
          await Dio().get('http://localhost:5000/exercise_equipment');

      setState(() {
        equipment = response.data;
      });
    } catch (e) {
      throw Exception('Failed to load equipment');
    }
  }

  Future<void> _createEquipment() async {
    try {
      final response = await Dio().post(
        'http://localhost:5000/exercise_equipment',
        data: {
          'Name': nameController.text,
          'Description': descriptionController.text,
          'Exercise_equipment_category_ID': selectedCategoryId,
        },
      );

      _getEquipment();
      nameController.clear();
      descriptionController.clear();
      selectedCategoryId = null;
    } catch (e) {
      throw Exception('Failed to create equipment');
    }
  }

  Future<void> _updateEquipment(int id) async {
    try {
      final response = await Dio().put(
        'http://localhost:5000/exercise_equipment/$id',
        data: {
          'Name': nameController.text,
          'Description': descriptionController.text,
          'Exercise_equipment_category_ID': selectedCategoryId,
        },
      );

      _getEquipment();
      nameController.clear();
      descriptionController.clear();
      selectedCategoryId = null;
    } catch (e) {
      throw Exception('Failed to update equipment');
    }
  }

  Future<void> _deleteEquipment(int id) async {
    try {
      final response =
          await Dio().delete('http://localhost:5000/exercise_equipment/$id');

      _getEquipment();
    } catch (e) {
      throw Exception('Failed to delete equipment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Тренажеры'),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField(
                                value: selectedCategoryId,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategoryId = value as int?;
                                  });
                                },
                                items: categories.map((category) {
                                  return DropdownMenuItem(
                                    value: category[
                                        'ID_Exercise_equipment_category'],
                                    child: Text(category['Name']),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: 'Категория',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  child: Text('Add'),
                                  onPressed: () {
                                    _createEquipment();
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('Update'),
                                  onPressed: () {
                                    _updateEquipment(
                                        equipment[selectedCategoryId!]
                                            ['ID_Exercise_equipment']);
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('Delete'),
                                  onPressed: () {
                                    _deleteEquipment(
                                        equipment[selectedCategoryId!]
                                            ['ID_Exercise_equipment']);
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: equipment.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: ListTile(
                                        onTap: () {
                                          _updateEquipment(
                                              equipment[selectedCategoryId!]
                                                  ['ID_Exercise_equipment']);
                                        },
                                        title: Text(equipment[index]['Name']),
                                        subtitle: Text(
                                            equipment[index]['Description']),
                                        trailing: Text(equipment[index][
                                                'Exercise_equipment_category_ID']
                                            .toString()),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  title: Text(categories[index]['Name']),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        final TextEditingController controller =
                                            TextEditingController(
                                                text: categories[index]
                                                    ['Name']);
                                        return AlertDialog(
                                          title: Text(
                                              'Изменение категории тренажера'),
                                          content: TextField(
                                            controller: controller,
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text('Отмена'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Изменить'),
                                              onPressed: () {
                                                _updateCategory(
                                                    categories[index][
                                                        'ID_Exercise_equipment_category'],
                                                    controller.text);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Удаление категории тренажера'),
                                                content: Text(
                                                    'Вы уверены, что хотите удалить ${categories[index]['Name']}?'),
                                                actions: [
                                                  TextButton(
                                                    child: Text('Отмена'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Удалить'),
                                                    onPressed: () {
                                                      _deleteCategory(categories[
                                                              index][
                                                          'ID_Exercise_equipment_category']);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
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
        )

        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         final TextEditingController controller = TextEditingController();
        //         return AlertDialog(
        //           title: Text('Добавление категории тренажера'),
        //           content: TextField(
        //             controller: controller,
        //           ),
        //           actions: [
        //             TextButton(
        //               child: Text('Отмена'),
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //             ),
        //             TextButton(
        //               child: Text('Добавить'),
        //               onPressed: () {
        //                 _createCategory(controller.text);
        //                 Navigator.of(context).pop();
        //               },
        //             ),
        //           ],
        //         );
        //       },
        //     );
        //   },
        // ),
        );
  }
}
