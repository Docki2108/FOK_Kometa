import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class exercise_equipment_page extends StatelessWidget {
  exercise_equipment_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExerciseEquipmentPage(),
    );
  }
}

class ExerciseEquipmentPage extends StatefulWidget {
  ExerciseEquipmentPage({Key? key}) : super(key: key);
  @override
  State<ExerciseEquipmentPage> createState() => _ExerciseEquipmentPageState();
}

class _ExerciseEquipmentPageState extends State<ExerciseEquipmentPage> {
  List<dynamic> _categories = [];
  List<dynamic> _exerciseEquipment = [];
  String? _selectedCategory;
  Map<String, String> _categoryNameMap = {};

  @override
  void initState() {
    super.initState();

    _loadCategories();
    _loadExerciseEquipment();
  }

  Future<void> _loadCategories() async {
    try {
      var response =
          await Dio().get('http://10.0.2.2:5000/exercise_equipment_category');
      setState(() {
        _categories = response.data;
        _categoryNameMap = Map.fromIterable(response.data,
            key: (category) =>
                category['ID_Exercise_equipment_category'].toString(),
            value: (category) => category['Name']);
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _loadExerciseEquipment() async {
    try {
      var response = await Dio().get('http://10.0.2.2:5000/exercise_equipment');
      setState(() {
        _exerciseEquipment = response.data;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  List<dynamic> _filterByCategory(String? category) {
    if (category == null || category.isEmpty) {
      return _exerciseEquipment;
    } else {
      return _exerciseEquipment
          .where((equipment) =>
              equipment['Exercise_equipment_category_ID.Name'] == category)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        title: const Text('Тренажеры'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _filterByCategory(_selectedCategory).length,
              itemBuilder: (BuildContext context, int index) {
                var equipment = _filterByCategory(_selectedCategory)[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        equipment['Name'],
                                        style: const TextStyle(
                                            color: const Color.fromARGB(
                                                255, 154, 185, 201),
                                            fontSize: 22),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
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
                      subtitle: Text(equipment['Description']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
