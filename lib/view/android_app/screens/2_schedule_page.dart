// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class schedule_page extends StatelessWidget {
  schedule_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String? _selectedCategory;
  List _group_workouts = [];
  String? _searchQuery;
  String? _searchText;

  Future<List<dynamic>> _fetchNews() async {
    try {
      final response = await Dio().get('http://10.0.2.2:5000/group_workouts');
      if (response.statusCode == 200) {
        return response.data['group_workouts'];
      } else {
        throw Exception('Failed to load group_workouts');
      }
    } catch (e) {
      throw Exception('Failed to load group_workouts: $e');
    }
  }

  List<String> _getCategories() {
    final categories = ['All'] +
        _group_workouts
            .map((group_workouts) =>
                group_workouts['group_workout_category'].toString())
            .toSet()
            .toList();

    return categories;
  }

  Future<void> _refreshNews() async {
    setState(() {
      _group_workouts = [];
    });
    final group_workouts = await _fetchNews();
    setState(() {
      _group_workouts = group_workouts;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchNews().then((group_workouts) {
      setState(() {
        _group_workouts = group_workouts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredNews = _selectedCategory == null || _selectedCategory == 'All'
        ? _group_workouts
        : _group_workouts
            .where((group_workouts) =>
                group_workouts['group_workout_category'] == _selectedCategory)
            .toList();

    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      final query = _searchQuery!.toLowerCase();
      filteredNews.retainWhere((group_workouts) =>
          group_workouts['title'].toString().toLowerCase().contains(query));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        title: const Text('Групповые тренировки'),
        actions: [
          PopupMenuButton(
            onSelected: (group_workout_category) {
              setState(() {
                _selectedCategory = group_workout_category;
                _searchText = null; // Clear search text
              });
            },
            itemBuilder: (BuildContext context) {
              final categories = ['All'] +
                  _group_workouts
                      .map((group_workouts) =>
                          group_workouts['group_workout_category'].toString())
                      .toSet()
                      .toList();

              return categories.map((group_workout_category) {
                return PopupMenuItem(
                  value: group_workout_category,
                  child: Text(group_workout_category),
                );
              }).toList();
            },
          ),

          // Добавляем строку поиска
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: ListView.builder(
          itemCount: filteredNews.length,
          itemBuilder: (BuildContext context, int index) {
            final group_workouts = filteredNews[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'с ' + group_workouts['start_time'].substring(0, 5),
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'до ' + group_workouts['end_time'].substring(0, 5),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      title: Text(
                        group_workouts['name'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        'Дата проведения: ' + group_workouts['event_date'],
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            group_workouts['description'],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Тренер: ' + group_workouts['coach'],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Балл нагрузки: ' +
                                group_workouts['load_score'].toString(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Рекомендуемый возраст: ' +
                                group_workouts['recommended_age'].toString() +
                                '+',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
