import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/news.dart';
import '../../../models/news_category.dart';
import '../../../theme/theme.dart';

class win_news_page extends StatelessWidget {
  const win_news_page({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: WinNewsPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class WinNewsPage extends StatefulWidget {
  @override
  _WinNewsPageState createState() => _WinNewsPageState();
}

class _WinNewsPageState extends State<WinNewsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  int? _selectedCategoryId;
  List<Map<String, dynamic>> _categories = [];
  List<News> newsList = [];
  List<NewsCategory> categories = [];

  List<NewsCategory> newsCategories = [];

  Future<void> getNewsCategories() async {
    try {
      final response = await Dio().get('http://localhost:5000/news_categories');
      if (response.statusCode == 200) {
        setState(() {
          newsCategories = (response.data['news_categories'] as List)
              .map((json) => NewsCategory.fromJson(json))
              .toList();
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> addNewsCategory(String name) async {
    try {
      final response = await Dio()
          .post('http://localhost:5000/news_categories', data: {'name': name});
      if (response.statusCode == 200) {
        final message = response.data['message'];
        print(message);
        getNewsCategories();
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> updateNewsCategory(int id, String name) async {
    try {
      final response = await Dio().put(
          'http://localhost:5000/news_categories/$id',
          data: {'name': name});
      if (response.statusCode == 200) {
        final message = response.data['message'];
        print(message);
        getNewsCategories();
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deleteNewsCategory(int id) async {
    try {
      final response =
          await Dio().delete('http://localhost:5000/news_categories/$id');
      if (response.statusCode == 200) {
        final message = response.data['message'];
        print(message);
        getNewsCategories();
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNews().then((news) {
      setState(() {
        _news = news;
      });
    });
    loadCategories();
    getNewsCategories();
  }

  Future<void> loadCategories() async {
    try {
      final response = await Dio().get('http://localhost:5000/news_categories');
      final List<dynamic> categoriesJson = response.data['news_categories'];
      setState(() {
        _categories = categoriesJson.cast<Map<String, dynamic>>();
      });
    } catch (e) {}
  }

  Future<void> addNews() async {
    if (_titleController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _selectedCategoryId == null) {
      return;
    }

    try {
      final response = await Dio().post('http://localhost:5000/news', data: {
        'title': _titleController.text,
        'content': _contentController.text,
        'category_id': _selectedCategoryId,
      });
      print(response.data);

      _titleController.clear();
      _contentController.clear();
      _selectedCategoryId = null;
      initState();
    } catch (e) {}
  }

  Future<void> deleteNews(int newsId) async {
    try {
      final response = await Dio().delete('http://localhost:5000/news/$newsId');

      log(response.data);
    } catch (e) {}
  }

  static const String route = "/win_news_page";
  String? _selectedCategory;
  List _news = [];
  String? _searchQuery;
  String? _searchText;

  Future<List<dynamic>> _fetchNews() async {
    try {
      final response = await Dio().get('http://localhost:5000/news');
      if (response.statusCode == 200) {
        return response.data['news'];
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
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
        title: const Text(
          'Новости',
        ),
        actions: [
          IconButton(
            onPressed: () {
              _refreshNews();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
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
                child: filteredNews.isEmpty
                    ? const Center(
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SelectableText(
                                        news['title'],
                                        style: const TextStyle(
                                            color: const Color.fromARGB(
                                                255, 154, 185, 201),
                                            fontSize: 22),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SelectableText(news['content']),
                                      ),
                                      Text(
                                        news['create_date'],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              deleteNews(news['id']);
                                              _refreshNews();
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
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.blueGrey,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _titleController,
                                            maxLength: 50,
                                            decoration: const InputDecoration(
                                              filled: true,
                                              hintText: 'Заголовок',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child:
                                                  DropdownButtonFormField<int>(
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Категория',
                                                  filled: true,
                                                ),
                                                value: _selectedCategoryId,
                                                onChanged: (int? value) {
                                                  setState(() {
                                                    _selectedCategoryId = value;
                                                  });
                                                },
                                                items:
                                                    _categories.map((category) {
                                                  return DropdownMenuItem<int>(
                                                    value: category['id'],
                                                    child:
                                                        Text(category['name']),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 33,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _contentController,
                                      maxLines: 5,
                                      minLines: 3,
                                      maxLength: 500,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        hintText: 'Содержание',
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    addNews();
                                    _refreshNews();
                                  },
                                  child: const Text('Добавить новость'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: ListView.builder(
                                  itemCount: newsCategories.length,
                                  itemBuilder: (context, index) {
                                    final newsCategory = newsCategories[index];
                                    return Card(
                                      child: ListTile(
                                        title: Text(newsCategory.name),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            deleteNewsCategory(newsCategory.id);
                                          },
                                        ),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              String newName =
                                                  newsCategory.name;
                                              return AlertDialog(
                                                title: const Text(
                                                    'Изменение категории новости'),
                                                content: TextField(
                                                  onChanged: (value) {
                                                    newName = value;
                                                  },
                                                  controller:
                                                      TextEditingController(
                                                          text: newsCategory
                                                              .name),
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Название',
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Отмена'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child:
                                                        const Text('Изменить'),
                                                    onPressed: () {
                                                      updateNewsCategory(
                                                          newsCategory.id,
                                                          newName);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String categoryName = '';
              return AlertDialog(
                title: const Text('Добавить категорию'),
                content: TextField(
                  onChanged: (value) {
                    categoryName = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Название',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Отмена'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Добавить'),
                    onPressed: () {
                      addNewsCategory(categoryName);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
