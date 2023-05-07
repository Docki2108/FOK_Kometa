import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fok_kometa/new_models/user.dart';
import 'package:provider/provider.dart';
import '../../../../theme/theme.dart';

class feedback_page extends StatelessWidget {
  const feedback_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: const FeedbackPage(),
        );
      }),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();

    super.dispose();
  }

  void _sendFeedback() async {
    try {
      var dio = Dio();
      var response = await dio.post(
        'http://10.0.2.2:5000/feedback',
        data: {'message': _feedbackController.text, 'user_id': User.get().id},
      );
      if (response.statusCode == 201) {
        log('Сообщение отправлено!');
      } else {
        log('Ошибка!');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text('Обратная связь'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Отправьте нам сообщение',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Если у вас есть какие-то вопросы - заполните форму ниже. Мы свяжемся с вами через ваш email или по номеру вашего телефона!',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _feedbackController,
                      decoration: const InputDecoration(
                        hintText: 'Сообщение',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _sendFeedback();
                        _feedbackController.clear();
                      },
                      child: const Text('Отправить'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 60,
                    ),
                    const Text(
                      'Адрес',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text('г. Москва'),
                    const Text('Велозаводская ул., стр. 55, д. 5'),
                    Container(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 30),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.phone,
                          size: 60,
                        ),
                        Text(
                          'Телефон',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text('+7 (495) 674-08-67'),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 30),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.tag_faces_rounded,
                          size: 60,
                        ),
                        Text(
                          'Всегда рады ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'помочь!',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
