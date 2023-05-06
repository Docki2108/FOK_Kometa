// import 'package:fluent_ui/fluent_ui.dart';
// // Определение виджетов для каждой страницы
// class PageOne extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page One'),
//       ),
//       body: Center(
//         child: Text('This is Page One'),
//       ),
//     );
//   }
// }

// class PageTwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page Two'),
//       ),
//       body: Center(
//         child: Text('This is Page Two'),
//       ),
//     );
//   }
// }

// class PageThree extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page Three'),
//       ),
//       body: Center(
//         child: Text('This is Page Three'),
//       ),
//     );
//   }
// }

// class PageFour extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page Four'),
//       ),
//       body: Center(
//         child: Text('This is Page Four'),
//       ),
//     );
//   }
// }

// class PageFive extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page Five'),
//       ),
//       body: Center(
//         child: Text('This is Page Five'),
//       ),
//     );
//   }
// }

// // Создание списка элементов навигации
// List<NavigationPaneItem> items = [
//   PaneItem(
//     icon: const Icon(FluentIcons.home),
//     title: const Text('Page One'),
//     body: const PageOne(),
//   ),
//   PaneItemSeparator(),
//   PaneItem(
//     icon: const Icon(FluentIcons.issue_tracking),
//     title: const Text('Page Two'),
//     body: const PageTwo(),
//   ),
//   PaneItemSeparator(),
//   PaneItem(
//     icon: const Icon(FluentIcons.disable_updates),
//     title: const Text('Page Three'),
//     body: const PageThree(),
//   ),
//   PaneItemSeparator(),
//   PaneItem(
//     icon: const Icon(FluentIcons.account_management),
//     title: const Text('Page Four'),
//     body: const PageFour(),
//   ),
//   PaneItemSeparator(),
//   PaneItem(
//     icon: const Icon(FluentIcons.settings),
//     title: const Text('Page Five'),
//     body: const PageFive(),
//   ),
// ];

// // Виджет NavigationView и NavigationPane
// NavigationView(
//   appBar: const NavigationAppBar(
//     title: Text('Navigation Example'),
//   ),
//   pane: NavigationPane(
//     selected: 0,
//     onChanged: (index) => setState(() {}),
//     displayMode: NavigationDisplayMode.minimal,
//     items: items,
//   ),
// );

// // class MyNavigationPage extends StatefulWidget {
// //   const MyNavigationPage({Key? key}) : super(key: key);

// //   @override
// //   State<MyNavigationPage> createState() => _MyNavigationPageState();
// // }

// // class _MyNavigationPageState extends State<MyNavigationPage> {
// //   int selectedIndex = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     return NavigationView(
// //       appBar: _getAppBar(),
// //       pane: _getNavigationPane(),
// //       content: _getNavigationBody(),
// //     );
// //   }

// //   _getAppBar() {
// //     return NavigationAppBar(
// //       title: Text(
// //         'Todo App',
// //         style: TextStyle(
// //           fontSize: 20,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //       actions: Row(
// //         children: [
// //           Spacer(),
// //           Align(
// //               alignment: Alignment.centerRight,
// //               child:
// //                   OutlinedButton(child: Text('Create Todo'), onPressed: () {})),
// //           SizedBox(
// //             width: 20,
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   _getNavigationPane() {
// //     return NavigationPane(
// //         header: FlutterLogo(
// //           style: FlutterLogoStyle.horizontal,
// //           size: 100,
// //         ),
// //         selected: selectedIndex,
// //         onChanged: (index) {
// //           setState(() {
// //             setState(() {
// //               selectedIndex = index;
// //             });
// //           });
// //         },
// //         items: [
// //           PaneItem(
// //             icon: const Icon(FluentIcons.to_do_logo_outline),
// //             body: const Text('Todo List'),
// //           ),
// //           PaneItem(
// //             icon: Icon(FluentIcons.settings),
// //             body: Text('Settings'),
// //           ),
// //         ]);
// //   }
// // }



// // class MyNavigationPage extends StatefulWidget {
// //   @override
// //   _MyNavigationPageState createState() => _MyNavigationPageState();
// // }

// // class _MyNavigationPageState extends State<MyNavigationPage> {
// //   static const String route = "/my_navigation_page";
// //   int _selectedIndex = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return FluentApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'My App',
// //       home: FluentTheme(
// //         data: FluentThemeData(
// //           accentColor: Colors.blue,
// //         ),
// //         child: ScaffoldPage(
// //           content: NavigationView(
// //             pane: NavigationPane(
// //               displayMode: PaneDisplayMode.compact,
// //               items: [
// //                 PaneItem(
// //                   icon: Icon(FluentIcons.home),
// //                   title: Text('Home'),
// //                   onTap: () {
// //                     setState(() {
// //                       _selectedIndex = 0;
// //                     });
// //                   },
// //                   body: Text('home'),
// //                 ),
// //                 PaneItem(
// //                   icon: Icon(FluentIcons.search),
// //                   title: const Text('Search'),
// //                   onTap: () {
// //                     setState(() {
// //                       _selectedIndex = 1;
// //                     });
// //                   },
// //                   body: Text('search'),
// //                 ),
// //                 PaneItem(
// //                   icon: Icon(FluentIcons.accept),
// //                   title: Text('Favorites'),
// //                   onTap: () {
// //                     setState(() {
// //                       _selectedIndex = 2;
// //                     });
// //                   },
// //                   body: Text('favorites'),
// //                 ),
// //                 PaneItem(
// //                   icon: Icon(FluentIcons.settings),
// //                   title: Text('Settings'),
// //                   onTap: () {
// //                     setState(() {
// //                       _selectedIndex = 3;
// //                     });
// //                   },
// //                   body: Text('settings'),
// //                 ),
// //               ],
// //             ),
// //             content: [
// //               Center(
// //                 child: Text('Home Page'),
// //               ),
// //               Center(
// //                 child: Text('Search Page'),
// //               ),
// //               Center(
// //                 child: Text('Favorites Page'),
// //               ),
// //               Center(
// //                 child: Text('Settings Page'),
// //               ),
// //             ][_selectedIndex],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
