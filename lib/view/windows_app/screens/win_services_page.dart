import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/new_models/user.dart';
import 'package:provider/provider.dart';
import '../../../new_models/service_category.dart';
import '../../../theme/theme.dart';

class win_services_page extends StatelessWidget {
  const win_services_page({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: WinServicesPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class WinServicesPage extends StatefulWidget {
  @override
  _WinServicesPageState createState() => _WinServicesPageState();
}

class _WinServicesPageState extends State<WinServicesPage> {
  List<dynamic> services = [];
  final nameController = TextEditingController();
  final costController = TextEditingController();
  final descriptionController = TextEditingController();
  final userIdController = TextEditingController();
  final categoryIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchServices().then((service) {});
  }

  String? _selectedCategory;
  List _services = [];
  String? _searchQuery;
  String? _searchText;
  List _filteredServices = [];

  Future<void> _fetchServices() async {
    try {
      final response = await Dio().get('http://localhost:5000/services');
      if (response.statusCode == 200) {
        final services = response.data['services'];
        setState(() {
          _services = services;
        });
      } else {
        throw Exception('Failed to load service');
      }
    } catch (e) {
      throw Exception('Failed to load service: $e');
    }
  }

  List<String> _getCategories() {
    final categories = ['Все'] +
        _filteredServices
            .map((service) => service['service_category'].toString())
            .toSet()
            .toList();

    return categories;
  }

  Future<void> _refreshNews() async {
    setState(() {
      _services = [];
    });
    final service = await _fetchServices();
  }

  Future<void> addService() async {
    try {
      Dio dio = Dio();

      Map<String, dynamic> serviceData = {
        'name': nameController.text,
        'cost': int.parse(costController.text),
        'description': descriptionController.text,
        'user_id': User.get().id,
        'category_id': int.parse(categoryIdController.text),
      };

      await dio.post('http://your-api-endpoint/service', data: serviceData);

      nameController.clear();
      costController.clear();
      descriptionController.clear();
      userIdController.clear();
      categoryIdController.clear();
    } catch (error) {
      print('Ошибка при добавлении услуги: $error');
    }
  }

  Future<void> deleteService(int id) async {
    try {
      Dio dio = Dio();

      await dio.delete('http://your-api-endpoint/service/$id');
    } catch (error) {
      print('Ошибка при удалении услуги: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _filteredServices = _selectedCategory == null ||
            _selectedCategory == 'Все'
        ? _services
        : _services
            .where(
                (service) => service['service_category'] == _selectedCategory)
            .toList();

    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      final query = _searchQuery!.toLowerCase();
      _filteredServices.retainWhere((service) =>
          service['title'].toString().toLowerCase().contains(query));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Витрина'),
        centerTitle: true,
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
                  onRefresh: _refreshNews,
                  child: ListView.builder(
                    itemCount: _filteredServices.length,
                    itemBuilder: (BuildContext context, int index) {
                      final service = _filteredServices[index];
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
                                                  service['name'],
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        service['description'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${service['cost']} руб.',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
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
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Название',
                                  ),
                                  controller: nameController,
                                ),
                                SizedBox(height: 8.0),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Стоимость',
                                  ),
                                  controller: costController,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 8.0),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Описание',
                                  ),
                                  controller: descriptionController,
                                ),
                                SizedBox(height: 8.0),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'ID категории',
                                  ),
                                  controller: categoryIdController,
                                  keyboardType: TextInputType.number,
                                ),
                                TextButton(
                                  child: Text('Добавить'),
                                  onPressed: () {
                                    addService();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
