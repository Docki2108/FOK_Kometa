import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/models/user.dart';
import 'package:provider/provider.dart';
import '../../../models/diet_category.dart';
import '../../../models/dish_category.dart';
import '../../../models/pfc.dart';
import '../../../models/service_category.dart';
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
  final _dietFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dietNameController = TextEditingController();
  final _dietDurationController = TextEditingController();
  final _dietCategoryController = TextEditingController();
  final _dishFormKey = GlobalKey<FormState>();
  final _dishScaffoldKey = GlobalKey<ScaffoldState>();
  final _dio = Dio();
  List<dynamic> _dishes = [];

  String? _dishName;
  int? _kcal;
  int? _pfcId;
  int? _dishdietId;
  int? _dishdishCategoryId;
  List<dynamic> _diets = [];

  @override
  void initState() {
    super.initState();
    _loadDietCategories();
    _loadPFC();
    _loadDishCategories();
    _getDiets();
    _getDishes();
  }

  void _getDishes() async {
    try {
      Response response = await Dio().get('http://localhost:5000/dishes');
      setState(() {
        _dishes = response.data;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _addDish() async {
    try {
      final response = await _dio.post('http://localhost:5000/dish', data: {
        'name': _dishName,
        'kcal': _kcal,
        'pfc_id': _pfcId,
        'diet_id': _dishdietId,
        'dish_category_id': _dishdishCategoryId,
      });

      _getDishes();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateDish(int id) async {
    try {
      final response = await _dio.put('http://localhost:5000/dish/$id', data: {
        'name': _dishName,
        'kcal': _kcal,
        'pfc_id': _pfcId,
        'diet_id': _dishdietId,
        'dish_category_id': _dishdishCategoryId,
      });

      _getDishes();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteDish(int id) async {
    try {
      final response = await _dio.delete('http://localhost:5000/dish/$id');

      _getDishes();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _dietNameController.dispose();
    _dietDurationController.dispose();
    _dietCategoryController.dispose();
    super.dispose();
  }

  Future<void> _getDiets() async {
    try {
      final response = await Dio().get('http://localhost:5000/diet');
      setState(() {
        _diets = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addDiet() async {
    try {
      final response = await Dio().post('http://localhost:5000/diet', data: {
        'name': _dietNameController.text,
        'duration': int.parse(_dietDurationController.text),
        'diet_category_id': int.parse(_dietCategoryController.text),
      });

      _getDiets();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateDiet(int id) async {
    try {
      final response = await Dio().put('http://localhost:5000/diet/$id', data: {
        'name': _dietNameController.text,
        'duration': int.parse(_dietDurationController.text),
        'diet_category_id': int.parse(_dietCategoryController.text),
      });

      _getDiets();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteDiet(int id) async {
    try {
      final response = await Dio().delete('http://localhost:5000/diet/$id');

      _getDiets();
    } catch (e) {
      print(e);
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Добавить диету'),
          content: Form(
            key: _dietFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLength: 100,
                  controller: _dietNameController,
                  decoration: const InputDecoration(
                    labelText: 'Название',
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите название';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _dietDurationController,
                  decoration: const InputDecoration(
                    labelText: 'Продолжительность',
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите продолжительность';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Введите число';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dietCategoryController,
                  decoration: const InputDecoration(
                    labelText: 'Код категории',
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите ID категории';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Введите число';
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
                if (_dietFormKey.currentState!.validate()) {
                  _addDiet();
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

  void _showEditDialog(dynamic diet) {
    _dietNameController.text = diet['name'];
    _dietDurationController.text = diet['duration'].toString();
    _dietCategoryController.text = diet['diet_category_id'].toString();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Изменить диету'),
          content: Form(
            key: _dietFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLength: 100,
                  controller: _dietNameController,
                  decoration: const InputDecoration(labelText: 'Название'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите название';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 3,
                  controller: _dietDurationController,
                  decoration:
                      const InputDecoration(labelText: 'Продолжительность'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите продолжительность';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Введите число';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dietCategoryController,
                  decoration: const InputDecoration(labelText: 'Код категории'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Введите ID категории';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Введите число';
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
                if (_dietFormKey.currentState!.validate()) {
                  _updateDiet(diet['id']);
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

  void _showDeleteDialog(dynamic diet) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Удалить диету'),
          content:
              Text('Вы действительно хотите удалить диету "${diet['name']}"?'),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            OutlinedButton(
              onPressed: () {
                _deleteDiet(diet['id']);
                Navigator.pop(context);
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
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
              maxLength: 4,
              controller: proteinsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Белки',
              ),
            ),
            TextField(
              maxLength: 4,
              controller: fatsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Жиры',
              ),
            ),
            TextField(
              maxLength: 4,
              controller: carbohydratesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Углеводы',
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
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
              maxLength: 4,
              controller: proteinsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Белки',
              ),
            ),
            TextField(
              maxLength: 4,
              controller: fatsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Жиры',
              ),
            ),
            TextField(
              maxLength: 4,
              controller: carbohydratesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Углеводы',
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
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
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
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
          decoration:
              const InputDecoration(filled: true, labelText: 'Название'),
          maxLength: 100,
          controller: nameController,
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
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
          decoration: const InputDecoration(
            hintText: 'Название',
            filled: true,
          ),
          maxLength: 100,
          controller: nameController,
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
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
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
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
          decoration:
              const InputDecoration(filled: true, labelText: 'Название'),
          maxLength: 100,
          controller: nameController,
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
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
          decoration: const InputDecoration(
            labelText: 'Название',
            filled: true,
          ),
          maxLength: 100,
          controller: nameController,
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
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
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          OutlinedButton(
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
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey[100],
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: _dishes.length,
                    itemBuilder: (context, index) {
                      final dish = _dishes[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0 ||
                              dish['diet']['name'] !=
                                  _dishes[index - 1]['diet']['name'])
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
                                            dish['diet']['name'],
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
                                    child: Column(
                                      children: [
                                        Text(
                                            'Категория: ${dish['diet']['category']}'),
                                        Text(
                                            'Количество дней: ${dish['diet']['duration']}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(dish['category']),
                                  subtitle: Text(dish['name']),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('ККал: ${dish['kcal']}'),
                                      Text(
                                          'БЖУ: ${dish['pfc']['proteins']}/${dish['pfc']['fats']}/${dish['pfc']['carbohydrates']}'),
                                    ],
                                  ),
                                  leading: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _deleteDish(dish['id']),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Изменить блюдо'),
                                          content: Form(
                                            key: _dishFormKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  maxLength: 100,
                                                  initialValue: dish['name'],
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Название',
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Введите название';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    _dishName = value;
                                                  },
                                                ),
                                                TextFormField(
                                                  maxLength: 5,
                                                  initialValue:
                                                      dish['kcal'].toString(),
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Калории',
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Введите количество калорий';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    _kcal = int.parse(value!);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            OutlinedButton(
                                              child: const Text('Отмена'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            OutlinedButton(
                                              child: const Text('Сохранить'),
                                              onPressed: () {
                                                if (_dishFormKey.currentState!
                                                    .validate()) {
                                                  _dishFormKey.currentState!
                                                      .save();
                                                  _updateDish(dish['id']);
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
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
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Добавить блюдо'),
                                      content: Form(
                                        key: _dishFormKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              maxLength: 100,
                                              decoration: const InputDecoration(
                                                filled: true,
                                                labelText: 'Название',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Введите название';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                _dishName = value;
                                              },
                                            ),
                                            TextFormField(
                                              maxLength: 5,
                                              decoration: const InputDecoration(
                                                filled: true,
                                                labelText: 'Калории',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Введите количество калорий';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                _kcal = int.parse(value!);
                                              },
                                            ),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                filled: true,
                                                labelText: 'Код БЖУ',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Введите Код PFC';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                _pfcId = int.parse(value!);
                                              },
                                            ),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                filled: true,
                                                labelText: 'Код диеты',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Введите Код диеты';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                _dishdietId = int.parse(value!);
                                              },
                                            ),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                filled: true,
                                                labelText:
                                                    'Код категории блюда',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Введите Код категории блюда';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                _dishdishCategoryId =
                                                    int.parse(value!);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                          child: const Text('Отмена'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        OutlinedButton(
                                          child: const Text('Добавить'),
                                          onPressed: () {
                                            if (_dishFormKey.currentState!
                                                .validate()) {
                                              _dishFormKey.currentState!.save();
                                              _addDish();
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Добавить блюдо'),
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
              color: Colors.blueGrey[200],
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: _diets.length,
                    itemBuilder: (context, index) {
                      final diet = _diets[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(diet['name']),
                            subtitle: Text(
                                'Продолжительность: ${diet['duration']} дней'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _showDeleteDialog(diet);
                              },
                            ),
                            onTap: () {
                              _showEditDialog(diet);
                            },
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
                              onPressed: () {
                                _showAddDialog();
                              },
                              child: const Text('Добавить диету'),
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
