import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/models/user.dart';
import 'package:provider/provider.dart';
import '../../../models/service_category.dart';
import '../../../theme/theme.dart';

class win_coachs_page extends StatelessWidget {
  const win_coachs_page({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: WinCoachsPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class WinCoachsPage extends StatefulWidget {
  @override
  _WinCoachsPageState createState() => _WinCoachsPageState();
}

class _WinCoachsPageState extends State<WinCoachsPage> {
  String? _work_experience;
  List _coaches = [];
  String? _searchQuery;
  String? _searchText;
  bool isLoading = false;
  List<Map<String, dynamic>> groupWorkoutCategories = [];

  final second_nameController = TextEditingController();
  final first_nameController = TextEditingController();
  final patronymicController = TextEditingController();
  final specializationController = TextEditingController();
  final work_experienceController = TextEditingController();

  Future<void> _fetchCoaches() async {
    try {
      final response = await Dio().get('http://localhost:5000/coaches');
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

  Future<void> addCoach() async {
    try {
      final response = await Dio().post('http://localhost:5000/coach', data: {
        'first_name': first_nameController.text,
        'patronymic': patronymicController.text,
        'second_name': second_nameController.text,
        'specialization': specializationController.text,
        'work_experience': work_experienceController.text,
      });
      print(response.data);

      initState();
      _refreshCoaches();
    } catch (e) {}
  }

  Future<void> _updateCoach(Map<String, dynamic> coachData) async {
    try {
      final coachId = coachData['id'];
      final response = await Dio()
          .put('http://localhost:5000/coach/$coachId', data: coachData);
      if (response.statusCode == 200) {
        _refreshCoaches();
      } else {}
    } catch (e) {}
  }

  Future<void> _deleteCoach(int coachId) async {
    try {
      final response =
          await Dio().delete('http://localhost:5000/coach/$coachId');
      if (response.statusCode == 200) {
        final message = response.data['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Удаление прошло успешно!'),
          ),
        );
        await _fetchCoaches();
      } else {
        throw Exception('Failed to delete coach');
      }
    } catch (e) {
      throw Exception('Failed to delete coach: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCoaches().then((_) {});
    _refreshCoaches();
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
        title: const Text('Тренеры'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _refreshCoaches();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Colors.blueGrey[100],
                child: RefreshIndicator(
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  coaches['specialization'],
                                                  style: const TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              154,
                                                              185,
                                                              201),
                                                      fontSize: 22),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Индивидуальный код тренера: ' +
                                          coaches['id'].toString(),
                                      style: const TextStyle(fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    const Text(' '),
                                    Text(
                                      coaches['second_name'] + ' ',
                                      style: const TextStyle(fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      coaches['first_name'] + ' ',
                                      style: const TextStyle(fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      coaches['patronymic'],
                                      style: const TextStyle(fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Стаж работы: ',
                                      style: TextStyle(fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      coaches['work_experience'],
                                      style: const TextStyle(fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      int.parse(coaches['work_experience']) %
                                                      10 ==
                                                  1 &&
                                              int.parse(coaches[
                                                      'work_experience']) !=
                                                  11
                                          ? ' год'
                                          : ' лет',
                                      style: const TextStyle(fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        _showEditCoachDialog(coaches);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteCoach(coaches['id']);
                                      },
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
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Добавить тренера'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    decoration: const InputDecoration(labelText: 'Фамилия'),
                    controller: second_nameController),
                TextField(
                    decoration: const InputDecoration(labelText: 'Имя'),
                    controller: first_nameController),
                TextField(
                    decoration: const InputDecoration(labelText: 'Отчество'),
                    controller: patronymicController),
                TextField(
                    decoration:
                        const InputDecoration(labelText: 'Специализация'),
                    controller: specializationController),
                TextField(
                    decoration: const InputDecoration(labelText: 'Стаж работы'),
                    controller: work_experienceController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                addCoach();
                Navigator.pop(context);
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  _showEditCoachDialog(Map<String, dynamic> coach) {
    final TextEditingController secondNameController =
        TextEditingController(text: coach['second_name']);
    final TextEditingController firstNameController =
        TextEditingController(text: coach['first_name']);
    final TextEditingController patronymicController =
        TextEditingController(text: coach['patronymic']);
    final TextEditingController specializationController =
        TextEditingController(text: coach['specialization']);
    final TextEditingController workExperienceController =
        TextEditingController(text: coach['work_experience']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редактирование тренера'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: second_nameController,
                decoration: const InputDecoration(labelText: 'Фамилия'),
              ),
              TextField(
                controller: first_nameController,
                decoration: const InputDecoration(labelText: 'Имя'),
              ),
              TextField(
                controller: patronymicController,
                decoration: const InputDecoration(labelText: 'Отчество'),
              ),
              TextField(
                controller: specializationController,
                decoration: const InputDecoration(labelText: 'Специализация'),
              ),
              TextField(
                controller: work_experienceController,
                decoration: const InputDecoration(labelText: 'Стаж работы'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                final coachData = {
                  'id': coach['id'],
                  'second_name': secondNameController.text,
                  'first_name': firstNameController.text,
                  'patronymic': patronymicController.text,
                  'specialization': specializationController.text,
                  'work_experience': workExperienceController.text,
                };
                _updateCoach(coachData);
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }
}
