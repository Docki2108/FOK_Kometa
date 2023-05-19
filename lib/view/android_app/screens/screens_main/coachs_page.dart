import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class coaches_page extends StatelessWidget {
  coaches_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CoachesPage(),
    );
  }
}

class CoachesPage extends StatefulWidget {
  CoachesPage({Key? key}) : super(key: key);
  @override
  State<CoachesPage> createState() => _CoachesPageState();
}

class _CoachesPageState extends State<CoachesPage> {
  String? _work_experience;
  List _coaches = [];
  String? _searchQuery;
  String? _searchText;
  bool isLoading = false;

  Future<void> _fetchCoaches() async {
    try {
      final response = await Dio().get('http://10.0.2.2:5000/coaches');
      if (response.statusCode == 200) {
        final coaches = response.data['coach'];
        setState(() {
          _coaches = coaches;
        });
      } else {
        throw Exception('Failed to load coaches');
      }
    } catch (e) {
      throw Exception('Failed to load coaches: $e');
    }
  }

  List<String> _getWork_experience() {
    final categories = ['Все'] +
        _coaches
            .map((coaches) => coaches['work_experience'].toString())
            .toSet()
            .toList();

    return categories;
  }

  @override
  void initState() {
    super.initState();
    _fetchCoaches().then((_) {});
  }

  Future<void> _refreshCoaches() async {
    setState(() {
      _coaches = [];
    });
    await _fetchCoaches();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filteredCoaches = _work_experience == null ||
            _work_experience == 'Все'
        ? _coaches
        : _coaches
            .where((coaches) => coaches['work_experience'] == _work_experience)
            .toList();

    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      final query = _searchQuery!.toLowerCase();
      filteredCoaches.retainWhere((coaches) =>
          coaches['work_experience'].toString().toLowerCase().contains(query));
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        title: const Text('Тренеры'),
        actions: [
          PopupMenuButton(
            onSelected: (work_experience) {
              setState(() {
                _work_experience = work_experience;
                _searchText = null;
              });
            },
            itemBuilder: (BuildContext context) {
              final categories = ['Все'] +
                  _coaches
                      .map((coaches) => coaches['work_experience'].toString())
                      .toSet()
                      .toList();

              return categories.map((work_experience) {
                return PopupMenuItem(
                  value: work_experience,
                  child: Text(work_experience),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: filteredCoaches.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshCoaches,
              child: ListView.builder(
                itemCount: filteredCoaches.length,
                itemBuilder: (BuildContext context, int index) {
                  final coaches = filteredCoaches[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
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
                                            child: Text(
                                              coaches['specialization'],
                                              style: const TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 154, 185, 201),
                                                  fontSize: 22),
                                              maxLines: 2,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  coaches['second_name'] + ' ',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  coaches['first_name'] + ' ',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  coaches['patronymic'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Стаж работы: ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  coaches['work_experience'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  int.parse(coaches['work_experience']) % 10 ==
                                              1 &&
                                          int.parse(
                                                  coaches['work_experience']) !=
                                              11
                                      ? ' год'
                                      : ' лет',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
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
