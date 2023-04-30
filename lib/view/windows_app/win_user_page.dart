import 'package:fluent_ui/fluent_ui.dart';

class MyNavigationPage extends StatefulWidget {
  @override
  _MyNavigationPageState createState() => _MyNavigationPageState();
}

class _MyNavigationPageState extends State<MyNavigationPage> {
  static const String route = "/my_navigation_page";
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: FluentTheme(
        data: FluentThemeData(
          accentColor: Colors.blue,
        ),
        child: ScaffoldPage(
          content: NavigationView(
            pane: NavigationPane(
              displayMode: PaneDisplayMode.compact,
              items: [
                PaneItem(
                  icon: Icon(FluentIcons.home),
                  title: Text('Home'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  body: Text('home'),
                ),
                PaneItem(
                  icon: Icon(FluentIcons.search),
                  title: Text('Search'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  body: Text('search'),
                ),
                PaneItem(
                  icon: Icon(FluentIcons.accept),
                  title: Text('Favorites'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  body: Text('favorites'),
                ),
                PaneItem(
                  icon: Icon(FluentIcons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  body: Text('settings'),
                ),
              ],
            ),
            content: [
              Center(
                child: Text('Home Page'),
              ),
              Center(
                child: Text('Search Page'),
              ),
              Center(
                child: Text('Favorites Page'),
              ),
              Center(
                child: Text('Settings Page'),
              ),
            ][_selectedIndex],
          ),
        ),
      ),
    );
  }
}
