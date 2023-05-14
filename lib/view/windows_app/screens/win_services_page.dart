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
  List<Map<String, dynamic>> serviceCategories = [];

  @override
  void initState() {
    super.initState();
    _fetchServices().then((service) {});
    fetchServiceCategories();
  }

  Future<void> fetchServiceCategories() async {
    try {
      final response =
          await Dio().get('http://localhost:5000/service_categories');
      if (response.statusCode == 200) {
        setState(() {
          serviceCategories = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        print('Failed to fetch service categories');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void addServiceCategory(String name) async {
    try {
      var response = await Dio()
          .post('http://localhost:5000/service_category', data: {'name': name});

      fetchServiceCategories();

      print('Add Service Category Response: $response');
    } catch (error) {
      print('Error: $error');
    }
  }

  void updateServiceCategory(int id, String name) async {
    try {
      var response = await Dio().put(
          'http://localhost:5000/service_category/$id',
          data: {'name': name});

      fetchServiceCategories();

      print('Update Service Category Response: $response');
    } catch (error) {
      print('Error: $error');
    }
  }

  void deleteServiceCategory(int id) async {
    try {
      var response =
          await Dio().delete('http://localhost:5000/service_category/$id');

      fetchServiceCategories();

      print('Delete Service Category Response: $response');
    } catch (error) {
      print('Error: $error');
    }
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

  Future<void> _refreshServices() async {
    setState(() {
      _services = [];
    });
    final service = await _fetchServices();
  }

  Future<void> addService() async {
    final data = {
      'name': nameController.text,
      'cost': costController.text,
      'description': descriptionController.text,
      'category_id': _selectedCategory,
    };

    try {
      final response = await Dio().post(
        'http://localhost:5000/service',
        data: data,
      );

      if (response.statusCode == 200) {
        print('Service added successfully!');
      } else {
        print('Failed to add service');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deleteService(int id) async {
    try {
      Dio dio = Dio();

      await dio.delete('http://localhost:5000/service/$id');
    } catch (error) {
      print('Ошибка при удалении услуги: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _filteredServices =
        _selectedCategory == null || _selectedCategory == 'Все'
            ? _services
            : _services;

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
                  onRefresh: _refreshServices,
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
                                                child: SelectableText(
                                                  service['name'],
                                                  style: const TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              154,
                                                              185,
                                                              201),
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SelectableText(
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
                                      SelectableText(
                                        '${service['cost']} руб.',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        deleteService(service['id']);
                                        _fetchServices();
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                )
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
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Название',
                                  ),
                                  maxLines: 5,
                                  minLines: 1,
                                  maxLength: 100,
                                  controller: nameController,
                                ),
                                SizedBox(height: 8.0),
                                TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Стоимость',
                                  ),
                                  maxLines: 5,
                                  minLines: 1,
                                  maxLength: 5,
                                  controller: costController,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 8.0),
                                TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Описание',
                                  ),
                                  maxLines: 5,
                                  minLines: 1,
                                  maxLength: 200,
                                  controller: descriptionController,
                                ),
                                SizedBox(height: 8.0),
                                DropdownButtonFormField<String>(
                                  value: _selectedCategory,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value!;
                                    });
                                  },
                                  items: serviceCategories.map((category) {
                                    return DropdownMenuItem<String>(
                                      value: category['ID_Service_category']
                                          .toString(),
                                      child: Text(category['Name']),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    labelText: 'Категория',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: Text('Добавить'),
                                    onPressed: () {
                                      addService();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  child: ListView.builder(
                                    itemCount: serviceCategories.length,
                                    itemBuilder: (context, index) {
                                      var category = serviceCategories[index];
                                      return Card(
                                        child: ListTile(
                                          title: Text(category['Name']),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                TextEditingController
                                                    controller =
                                                    TextEditingController(
                                                  text: category['Name'],
                                                );
                                                return AlertDialog(
                                                  title: Text(
                                                      'Изменить категорию'),
                                                  content: TextField(
                                                    controller: controller,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('Cancel'),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    TextButton(
                                                      child: Text('Save'),
                                                      onPressed: () {
                                                        updateServiceCategory(
                                                            category[
                                                                'ID_Service_category'],
                                                            controller.text);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: Text(
                                                          'Удалить категорию'),
                                                      content:
                                                          Text('Вы уверены?'),
                                                      actions: [
                                                        TextButton(
                                                          child: Text('Отмена'),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                        ),
                                                        TextButton(
                                                          child:
                                                              Text('Удалить'),
                                                          onPressed: () {
                                                            deleteServiceCategory(
                                                                category[
                                                                    'ID_Service_category']);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController controller = TextEditingController();
              return AlertDialog(
                title: Text('Добавить категорию'),
                content: TextField(
                  controller: controller,
                ),
                actions: [
                  TextButton(
                    child: Text('Отмена'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: Text('Добавить'),
                    onPressed: () {
                      addServiceCategory(controller.text);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
