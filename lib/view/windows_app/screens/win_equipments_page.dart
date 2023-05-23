import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/exercise_equipment_category.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dio = Dio();
  List<dynamic> _equipmentList = [];
  List<dynamic> _categoryList = [];
  int? _selectedCategoryId;
  int? _selectedEquipmentId;
  String _name = '';
  String _description = '';
  final TextEditingController _nameController = TextEditingController();
  List<ExerciseEquipmentCategory> _categories = [];

  @override
  void initState() {
    super.initState();
    _getEquipmentList();
    _getCategoryList();
    _getCategories();
  }

  Future<void> _getCategories() async {
    try {
      final response =
          await _dio.get('http://localhost:5000/exercise_equipment_category');
      final List<dynamic> data = response.data;
      setState(() {
        _categories = data
            .map((category) => ExerciseEquipmentCategory.fromJson(category))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addCategory() async {
    try {
      final response = await _dio
          .post('http://localhost:5000/exercise_equipment_category', data: {
        'Name': _nameController.text,
      });
      print(response.data);
      _getCategories();
      _nameController.clear();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateCategory(ExerciseEquipmentCategory category) async {
    try {
      final response = await _dio.put(
          'http://localhost:5000/exercise_equipment_category/${category.id}',
          data: {
            'Name': _nameController.text,
          });
      print(response.data);
      _getCategories();
      _nameController.clear();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteCategory(ExerciseEquipmentCategory category) async {
    try {
      final response = await _dio.delete(
          'http://localhost:5000/exercise_equipment_category/${category.id}');
      print(response.data);
      _getCategories();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getEquipmentList() async {
    try {
      final response =
          await _dio.get('http://localhost:5000/exercise_equipment');
      setState(() {
        _equipmentList = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getCategoryList() async {
    try {
      final response =
          await _dio.get('http://localhost:5000/exercise_equipment_category');
      setState(() {
        _categoryList = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _createEquipment() async {
    try {
      final response = await _dio.post(
        'http://localhost:5000/exercise_equipment',
        data: {
          'Name': _name,
          'Description': _description,
          'Exercise_equipment_category_ID': _selectedCategoryId,
        },
      );

      _getEquipmentList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateEquipment() async {
    try {
      final response = await _dio.put(
        'http://localhost:5000/exercise_equipment/$_selectedEquipmentId',
        data: {
          'Name': _name,
          'Description': _description,
          'Exercise_equipment_category_ID': _selectedCategoryId,
        },
      );

      _getEquipmentList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteEquipment() async {
    try {
      final response = await _dio.delete(
          'http://localhost:5000/exercise_equipment/$_selectedEquipmentId');
      _getEquipmentList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тренажеры'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _getEquipmentList();
              _getCategoryList();
              _getCategories();
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
                itemCount: _equipmentList.length,
                itemBuilder: (context, index) {
                  final equipment = _equipmentList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SelectableText(
                                              equipment['Name'],
                                              style: const TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 154, 185, 201),
                                                  fontSize: 22),
                                              maxLines: 3,
                                              minLines: 1,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            equipment['Description'],
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _selectedEquipmentId =
                                  equipment['ID_Exercise_equipment'];
                            });
                            _deleteEquipment();
                          },
                        ),
                        onTap: () {
                          setState(
                            () {
                              _selectedEquipmentId =
                                  equipment['ID_Exercise_equipment'];
                              _name = equipment['Name'];
                              _description = equipment['Description'];
                              _selectedCategoryId =
                                  equipment['Exercise_equipment_category_ID'];
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
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  maxLength: 100,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'Название',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Введите название';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _name = value!;
                                  },
                                ),
                                TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  maxLength: 300,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'Описание',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Введите описание';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _description = value!;
                                  },
                                ),
                                DropdownButtonFormField(
                                  value: _selectedCategoryId,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategoryId = value as int?;
                                    });
                                  },
                                  items: _categoryList.map((category) {
                                    return DropdownMenuItem(
                                      value: category[
                                          'ID_Exercise_equipment_category'],
                                      child: Text(category['Name']),
                                    );
                                  }).toList(),
                                  decoration: const InputDecoration(
                                    filled: true,
                                    labelText: 'Категория',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _createEquipment();
                                    }
                                  },
                                  child: const Text('Добавить'),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // child: Stack(
                  //   children: [],
                  // ),
                ),
                Expanded(
                  child: Stack(children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            final category = _categories[index];
                            return Card(
                              child: ListTile(
                                title: Text(category.name),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Удалить категорию?'),
                                          content: Text(
                                              'Вы уверены, что хотите удалить категорию "${category.name}"?'),
                                          actions: <Widget>[
                                            OutlinedButton(
                                              child: const Text('Отмена'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            OutlinedButton(
                                              child: const Text('Удалить'),
                                              onPressed: () {
                                                _deleteCategory(category);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                onTap: () {
                                  _nameController.text = category.name;
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Изменить категорию'),
                                        content: TextField(
                                          controller: _nameController,
                                          decoration: const InputDecoration(
                                              hintText: 'Название категории'),
                                        ),
                                        actions: <Widget>[
                                          OutlinedButton(
                                            child: const Text('Отмена'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _nameController.clear();
                                            },
                                          ),
                                          OutlinedButton(
                                            child: const Text('Сохранить'),
                                            onPressed: () {
                                              _updateCategory(category);
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
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Добавить категорию'),
                content: TextField(
                  maxLength: 100,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Название категории',
                    filled: true,
                  ),
                ),
                actions: <Widget>[
                  OutlinedButton(
                    child: const Text('Отмена'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _nameController.clear();
                    },
                  ),
                  OutlinedButton(
                    child: const Text('Добавить'),
                    onPressed: () {
                      _addCategory();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
