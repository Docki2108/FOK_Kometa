import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class services_page extends StatelessWidget {
  services_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ServicesPage(),
    );
  }
}

class ServicesPage extends StatefulWidget {
  ServicesPage({Key? key}) : super(key: key);
  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  String? _selectedCategory;
  List _services = [];
  String? _searchQuery;
  String? _searchText;
  List _filteredNews = [];

  Future<void> _fetchServices() async {
    try {
      final response = await Dio().get('http://10.0.2.2:5000/services');
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
        _filteredNews
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

  @override
  void initState() {
    super.initState();
    _fetchServices().then((service) {});
  }

  @override
  Widget build(BuildContext context) {
    final _filteredNews = _selectedCategory == null ||
            _selectedCategory == 'Все'
        ? _services
        : _services
            .where(
                (service) => service['service_category'] == _selectedCategory)
            .toList();

    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      final query = _searchQuery!.toLowerCase();
      _filteredNews.retainWhere((service) =>
          service['title'].toString().toLowerCase().contains(query));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        title: const Text('Витрина'),
        actions: [
          PopupMenuButton(
            onSelected: (service_category) {
              setState(() {
                _selectedCategory = service_category;
                _searchText = null; // Clear search text
              });
            },
            itemBuilder: (BuildContext context) {
              final categories = ['Все'] +
                  _filteredNews
                      .map((service) => service['service_category'].toString())
                      .toSet()
                      .toList();

              return categories.map((service_category) {
                return PopupMenuItem(
                  value: service_category,
                  child: Text(service_category),
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
          itemCount: _filteredNews.length,
          itemBuilder: (BuildContext context, int index) {
            final service = _filteredNews[index];
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
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        service['name'],
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
    );
  }
}
