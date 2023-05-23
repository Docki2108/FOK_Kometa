import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../../../theme/theme.dart';
import 'screens_options/about_app_page.dart';

class options_page extends StatelessWidget {
  const options_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: const OptionsPage(),
        );
      }),
    );
  }
}

class OptionsPage extends StatefulWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text('Настройки'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Card(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Изменить тему    '),
                      Consumer<ThemeNotifier>(
                        builder: (context, notifier, child) => SwitcherButton(
                          size: 50,
                          offColor: const Color.fromRGBO(145, 145, 145, 1),
                          onColor: Colors.black,
                          value: notifier.darkTheme,
                          onChange: (val) {
                            notifier.toggleTheme();
                            log('Тема изменена');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AboutAppPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'О приложении',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
