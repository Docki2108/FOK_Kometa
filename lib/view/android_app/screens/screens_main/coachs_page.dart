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
    _fetchCoaches().then((_) {
      // do something after the coaches are fetched
    });
  }

  Future<void> _refreshNews() async {
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
          // Padding(
          //   padding:
          //       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          //   child: SizedBox(
          //     width: 200.0,
          //     child: TextField(
          //       decoration: const InputDecoration(
          //         hintText: 'Поиск по заголовку',
          //       ),
          //       onChanged: (text) {
          //         setState(() {
          //           _searchQuery = text;
          //         });
          //       },
          //     ),
          //   ),
          // ),
          PopupMenuButton(
            onSelected: (work_experience) {
              setState(() {
                _work_experience = work_experience;
                _searchText = null; // Clear search text
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
      body: RefreshIndicator(
        onRefresh: _refreshNews,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    coaches['specialization'],
                                    style: const TextStyle(
                                        color: Colors.blue, fontSize: 32),
                                  ),
                                  Text(
                                    coaches['first_name']?.substring(0, 1),
                                    style: const TextStyle(
                                        color: Colors.blue, fontSize: 32),
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
                          // if (coaches['work_experience']
                          //     .str
                          //     .substring(str.length - 1))
                          //   Text(' год'),
                          // if (coaches['work_experience'].lastChars(1) == 2)
                          //   Text(' года'),
                          // if (coaches['work_experience'].lastChars(1) == 3)
                          //   Text(' года'),
                          // if (coaches['work_experience'].lastChars(1) == 4)
                          //   Text(' года'),
                          // if (coaches['work_experience'].lastChars(1) == 5)
                          //   Text(' лет'),
                          // if (coaches['work_experience'].lastChars(1) == 6)
                          //   Text(' лет'),
                          // if (coaches['work_experience'].lastChars(1) == 7)
                          //   Text(' лет'),
                          // if (coaches['work_experience'].lastChars(1) == 8)
                          //   Text(' лет'),
                          // if (coaches['work_experience'].lastChars(1) == 9)
                          //   Text(' лет'),
                          // if (coaches['work_experience'].lastChars(1) == 0)
                          //   Text(' лет'),
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
