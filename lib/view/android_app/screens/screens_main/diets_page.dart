import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DishesPage extends StatefulWidget {
  @override
  _DishesPageState createState() => _DishesPageState();
}

class _DishesPageState extends State<DishesPage> {
  List<dynamic> _dishes = [];

  @override
  void initState() {
    super.initState();
    _getDishes();
  }

  void _getDishes() async {
    try {
      Response response = await Dio().get('http://10.0.2.2:5000/dishes');
      setState(() {
        _dishes = response.data;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Диеты'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _dishes.length,
        itemBuilder: (context, index) {
          final dish = _dishes[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 ||
                  dish['diet']['name'] != _dishes[index - 1]['diet']['name'])
                Stack(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 154, 185, 201),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dish['diet']['name'],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 27, 94, 150),
                                        fontSize: 22),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text('Категория: ${dish['diet']['category']}'),
                          Text('Количество дней: ${dish['diet']['duration']}'),
                        ],
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(dish['category']),
                      subtitle: Text(dish['name']),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('ККал: ${dish['kcal']}'),
                          Text(
                              'БЖУ: ${dish['pfc']['proteins']}/${dish['pfc']['fats']}/${dish['pfc']['carbohydrates']}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
