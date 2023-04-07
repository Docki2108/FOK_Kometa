import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../../theme/theme.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Изменить тему    '),
              Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => SwitcherButton(
                  size: 50,
                  offColor: Color.fromRGBO(145, 145, 145, 1),
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
          ElevatedButton(
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
        ]),
      ),
    );
  }
}
