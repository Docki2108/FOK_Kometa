import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/new_models/user.dart';
import 'package:provider/provider.dart';
import '../../../new_models/diet_category.dart';
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
            home: DietCategoryPage(),
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

class DietCategoryPage extends StatefulWidget {
  @override
  _DietCategoryPageState createState() => _DietCategoryPageState();
}

class _DietCategoryPageState extends State<DietCategoryPage> {
  List<DietCategory> _dietCategories = [];

  @override
  void initState() {
    super.initState();
    _loadDietCategories();
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
        title: Text('Добавить категорию диеты'),
        content: TextField(
          controller: nameController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
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
            child: Text('Добавить'),
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
        title: Text('Редактировать категорию диеты'),
        content: TextField(
          controller: nameController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
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
            child: Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDietCategory(DietCategory dietCategory) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Удалить категорию диеты?'),
        content: Text(
            'Вы уверены, что хотите удалить категорию "${dietCategory.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Удалить'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Категории диет'),
      ),
      body: ListView.builder(
        itemCount: _dietCategories.length,
        itemBuilder: (context, index) {
          final dietCategory = _dietCategories[index];
          return ListTile(
            title: Text(dietCategory.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteDietCategory(dietCategory),
            ),
            onTap: () => _editDietCategory(dietCategory),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDietCategory,
        child: Icon(Icons.add),
      ),
    );
  }
}
