import 'package:flutter/material.dart';

class testpages extends StatelessWidget {
  const testpages({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const testpagesPage(),
    );
  }
}

class testpagesPage extends StatefulWidget {
  const testpagesPage({super.key});

  @override
  State<testpagesPage> createState() => _testpagesState();
}

class _testpagesState extends State<testpagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: Center(child: Text('textToShow')),
    );
  }
}
