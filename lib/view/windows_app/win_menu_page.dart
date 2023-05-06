import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';
import 'screens/win_news_page.dart';

class win_menu_page extends StatelessWidget {
  const win_menu_page({super.key});
  static const String route = "/win_menu_page";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            home: WinLoginPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class WinLoginPage extends StatefulWidget {
  @override
  _WinLoginPageState createState() => _WinLoginPageState();
}

class _WinLoginPageState extends State<WinLoginPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text(
                  'Главная страница',
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text(
                  '2',
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.exit_to_app),
                label: Text(
                  'Выход',
                ),
              ),
            ],
          ),
          Expanded(
            child: buildPages(),
          )
        ],
      ),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return win_news_page();
    }
    return Container();
  }
}
