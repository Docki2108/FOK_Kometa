import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../../theme/theme.dart';
import 'screens_options/about_app_page.dart';

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
            const Icon(
              Icons.phone,
              size: 60,
            ),
            const Text(
              'Телефон',
              style: TextStyle(fontSize: 20),
            ),
            const Text('+7 (495) 674-08-67'),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              margin: const EdgeInsets.fromLTRB(20, 36, 20, 30),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
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
                    'Если у вас есть какие-то вопросы - заполните форму ниже. Мы свяжемся с вами через ваш email или по номеру вашего телефона',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Сообщение',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Отправить'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
