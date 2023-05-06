import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  static const String route = "/win_news_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Color.fromARGB(255, 216, 228, 255)],
          ),
        ),
        child: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          const Text(
                            'Авторизация',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 300.0, // ограничение по ширине
                              maxHeight: 50.0, // ограничение по высоте
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                hintText: 'Почта',
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 300.0,
                              maxHeight: 50.0,
                            ),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                hintText: 'Пароль',
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Войти'),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Перейти'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
