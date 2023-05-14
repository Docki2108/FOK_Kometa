import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/new_models/user.dart';
import 'package:provider/provider.dart';
import '../../../new_models/diet_category.dart';
import '../../../new_models/dish_category.dart';
import '../../../new_models/pfc.dart';
import '../../../new_models/service_category.dart';
import '../../../theme/theme.dart';

class win_diets_page extends StatelessWidget {
  const win_diets_page({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: WinDietsPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

const String baseUrl = 'http://localhost:5000';

Future<List<DietCategory>> getDietCategories() async {
  final response = await Dio().get('$baseUrl/diet_categories');
  final data = response.data['diet_categories'] as List;
  return data.map((json) => DietCategory.fromJson(json)).toList();
}

Future<void> addDietCategory(String name) async {
  final data = {'name': name};
  await Dio().post('$baseUrl/diet_categories', data: data);
}

Future<void> updateDietCategory(int id, String name) async {
  final data = {'name': name};
  await Dio().put('$baseUrl/diet_categories/$id', data: data);
}

Future<void> deleteDietCategory(int id) async {
  await Dio().delete('$baseUrl/diet_categories/$id');
}

class WinDietsPage extends StatefulWidget {
  @override
  _WinDietsPageState createState() => _WinDietsPageState();
}

class _WinDietsPageState extends State<WinDietsPage> {
  List<DietCategory> _dietCategories = [];
  List<PFC> _pfc = [];
  List<DishCategory> _dishCategories = [];

  @override
  void initState() {
    super.initState();
    _loadDietCategories();
    _loadPFC();
    _loadDishCategories();
  }

  Future<void> _loadPFC() async {
    try {
      final pfc = await getPFC();
      setState(() {
        _pfc = pfc;
      });
    } on DioError catch (e) {
      print('Error loading PFC: ${e.message}');
    }
  }

  Future<void> _addPFC() async {
    final proteinsController = TextEditingController();
    final fatsController = TextEditingController();
    final carbohydratesController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить запись БЖУ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: proteinsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Белки',
              ),
            ),
            TextField(
              controller: fatsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Жиры',
              ),
            ),
            TextField(
              controller: carbohydratesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Углеводы',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              final proteins = int.tryParse(proteinsController.text);
              final fats = int.tryParse(fatsController.text);
              final carbohydrates = int.tryParse(carbohydratesController.text);
              if (proteins != null && fats != null && carbohydrates != null) {
                try {
                  await addPFC(proteins, fats, carbohydrates);
                  await _loadPFC();
                } on DioError catch (e) {
                  print('Error adding PFC: ${e.message}');
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  Future<void> _editPFC(PFC pfc) async {
    final proteinsController =
        TextEditingController(text: pfc.proteins.toString());
    final fatsController = TextEditingController(text: pfc.fats.toString());
    final carbohydratesController =
        TextEditingController(text: pfc.carbohydrates.toString());
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать запись БЖУ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: proteinsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Белки',
              ),
            ),
            TextField(
              controller: fatsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Жиры',
              ),
            ),
            TextField(
              controller: carbohydratesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Углеводы',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              final proteins = int.tryParse(proteinsController.text);
              final fats = int.tryParse(fatsController.text);
              final carbohydrates = int.tryParse(carbohydratesController.text);
              if (proteins != null && fats != null && carbohydrates != null) {
                try {
                  await updatePFC(pfc.id, proteins, fats, carbohydrates);
                  await _loadPFC();
                } on DioError catch (e) {
                  print('Error updating PFC: ${e.message}');
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePFC(PFC pfc) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить запись БЖУ?'),
        content: const Text('Вы уверены, что хотите удалить запись БЖУ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await deletePFC(pfc.id);
        await _loadPFC();
      } on DioError catch (e) {
        print('Error deleting PFC: ${e.message}');
      }
    }
  }

  Future<void> _loadDietCategories() async {
    try {
      final dietCategories = await getDietCategories();
      setState(() {
        _dietCategories = dietCategories;
      });
    } on DioError catch (e) {
      print('Error loading diet categories: ${e.message}');
    }
  }

  Future<void> _addDietCategory() async {
    final nameController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить категорию диеты'),
        content: TextField(
          controller: nameController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text;
              if (name.isNotEmpty) {
                try {
                  await addDietCategory(name);
                  await _loadDietCategories();
                } on DioError catch (e) {
                  print('Error adding diet category: ${e.message}');
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  Future<void> _editDietCategory(DietCategory dietCategory) async {
    final nameController = TextEditingController(text: dietCategory.name);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать категорию диеты'),
        content: TextField(
          controller: nameController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text;
              if (name.isNotEmpty) {
                try {
                  await updateDietCategory(dietCategory.id, name);
                  await _loadDietCategories();
                } on DioError catch (e) {
                  print('Error updating diet category: ${e.message}');
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDietCategory(DietCategory dietCategory) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить категорию диеты?'),
        content: Text(
            'Вы уверены, что хотите удалить категорию "${dietCategory.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await deleteDietCategory(dietCategory.id);
        await _loadDietCategories();
      } on DioError catch (e) {
        print('Error deleting diet category: ${e.message}');
      }
    }
  }

  Future<List<PFC>> getPFC() async {
    final response = await Dio().get('$baseUrl/pfc');
    final data = response.data as List;
    return data.map((json) => PFC.fromJson(json)).toList();
  }

  Future<void> addPFC(int proteins, int fats, int carbohydrates) async {
    final data = {
      'proteins': proteins,
      'fats': fats,
      'carbohydrates': carbohydrates
    };
    await Dio().post('$baseUrl/pfc', data: data);
  }

  Future<void> updatePFC(
      int id, int proteins, int fats, int carbohydrates) async {
    final data = {
      'proteins': proteins,
      'fats': fats,
      'carbohydrates': carbohydrates
    };
    await Dio().put('$baseUrl/pfc/$id', data: data);
  }

  Future<void> deletePFC(int id) async {
    await Dio().delete('$baseUrl/pfc/$id');
  }

  Future<List<DishCategory>> getDishCategories() async {
    final response = await Dio().get('$baseUrl/dish_categories');
    final data = response.data as List;
    return data.map((json) => DishCategory.fromJson(json)).toList();
  }

  Future<void> addDishCategory(String name) async {
    final data = {'name': name};
    await Dio().post('$baseUrl/dish_categories', data: data);
  }

  Future<void> updateDishCategory(int id, String name) async {
    final data = {'name': name};
    await Dio().put('$baseUrl/dish_categories/$id', data: data);
  }

  Future<void> deleteDishCategory(int id) async {
    await Dio().delete('$baseUrl/dish_categories/$id');
  }

  Future<void> _loadDishCategories() async {
    try {
      final dishCategories = await getDishCategories();
      setState(() {
        _dishCategories = dishCategories;
      });
    } on DioError catch (e) {
      print('Error loading dish categories: ${e.message}');
    }
  }

  Future<void> _addDishCategory() async {
    final nameController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить категорию блюд'),
        content: TextField(
          controller: nameController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text;
              if (name.isNotEmpty) {
                try {
                  await addDishCategory(name);
                  await _loadDishCategories();
                } on DioError catch (e) {
                  print('Error adding dish category: ${e.message}');
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  Future<void> _editDishCategory(DishCategory dishCategory) async {
    final nameController = TextEditingController(text: dishCategory.name);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать категорию блюд'),
        content: TextField(
          controller: nameController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text;
              if (name.isNotEmpty) {
                try {
                  await updateDishCategory(dishCategory.id, name);
                  await _loadDishCategories();
                } on DioError catch (e) {
                  print('Error updating dish category: ${e.message}');
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDishCategory(DishCategory dishCategory) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить категорию блюд?'),
        content: Text(
            'Вы уверены, что хотите удалить категорию "${dishCategory.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await deleteDishCategory(dishCategory.id);
        await _loadDishCategories();
      } on DioError catch (e) {
        print('Error deleting dish category: ${e.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Диеты'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey[100],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey[100],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Stack(
                      children: [
                        ListView.builder(
                          itemCount: _dishCategories.length,
                          itemBuilder: (context, index) {
                            final dishCategory = _dishCategories[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  title: Text(dishCategory.name),
                                  subtitle: Text('Код категории блюда: ' +
                                      dishCategory.id.toString()),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        _deleteDishCategory(dishCategory),
                                  ),
                                  onTap: () => _editDishCategory(dishCategory),
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
                                    onPressed: _addDishCategory,
                                    child:
                                        const Text('Добавить категорию блюд'),
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
                  child: Container(
                    color: Colors.blueGrey[300],
                    child: Stack(
                      children: [
                        ListView.builder(
                          itemCount: _pfc.length,
                          itemBuilder: (context, index) {
                            final pfc = _pfc[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                      'Белки: ${pfc.proteins}, Жиры: ${pfc.fats}, Углеводы: ${pfc.carbohydrates}'),
                                  subtitle: Text(
                                    'Код БЖУ: ' + pfc.id.toString(),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _deletePFC(pfc),
                                  ),
                                  onTap: () => _editPFC(pfc),
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
                                    onPressed: _addPFC,
                                    child: const Text('Добавить БЖУ'),
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
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: _dietCategories.length,
                        itemBuilder: (context, index) {
                          final dietCategory = _dietCategories[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                title: Text(dietCategory.name),
                                subtitle: Text(
                                  'Код категории:   ' +
                                      dietCategory.id.toString(),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteDietCategory(dietCategory),
                                ),
                                onTap: () => _editDietCategory(dietCategory),
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
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  onPressed: _addDietCategory,
                                  child: const Text('Добавить категорию диеты'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
