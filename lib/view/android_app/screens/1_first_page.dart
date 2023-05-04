import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class first_page extends StatelessWidget {
  first_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String? _selectedCategory;
  List _news = [];
  String? _searchQuery;
  String? _searchText;

  Future<List<dynamic>> _fetchNews() async {
    try {
      final response = await Dio().get('http://10.0.2.2:5000/news');
      if (response.statusCode == 200) {
        return response.data['news'];
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  List<String> _getCategories() {
    final categories = ['All'] +
        _news.map((news) => news['category'].toString()).toSet().toList();

    return categories;
  }

  Future<void> _refreshNews() async {
    setState(() {
      _news = [];
    });
    final news = await _fetchNews();
    setState(() {
      _news = news;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchNews().then((news) {
      setState(() {
        _news = news;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredNews = _selectedCategory == null || _selectedCategory == 'Все'
        ? _news
        : _news.where((news) => news['category'] == _selectedCategory).toList();

    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      final query = _searchQuery!.toLowerCase();
      filteredNews.retainWhere(
          (news) => news['title'].toString().toLowerCase().contains(query));
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        title: const Text('Новости'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SizedBox(
              width: 200.0,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Поиск по заголовку',
                ),
                onChanged: (text) {
                  setState(() {
                    _searchQuery = text;
                  });
                },
              ),
            ),
          ),
          PopupMenuButton(
            onSelected: (category) {
              setState(() {
                _selectedCategory = category;
                _searchText = null; // Clear search text
              });
            },
            itemBuilder: (BuildContext context) {
              final categories = ['Все'] +
                  _news
                      .map((news) => news['category'].toString())
                      .toSet()
                      .toList();

              return categories.map((category) {
                return PopupMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList();
            },
          ),

          // Добавляем строку поиска
        ],
      ),
      body: filteredNews.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshNews,
              child: ListView.builder(
                itemCount: filteredNews.length,
                itemBuilder: (BuildContext context, int index) {
                  final news = filteredNews[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              news['title'],
                              // style: const TextStyle(fontSize: 18),
                              style: const TextStyle(
                                  color:
                                      const Color.fromARGB(255, 154, 185, 201),
                                  fontSize: 22),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(news['content']),
                            ),
                            Text(
                              news['create_date'],
                            )
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
