import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class win_feedback_page extends StatelessWidget {
  win_feedback_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackPage(),
    );
  }
}

//
class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<dynamic> _feedbackMessages = [];

  @override
  void initState() {
    super.initState();
    _fetchFeedbackMessages();
  }

  Future<void> _fetchFeedbackMessages() async {
    try {
      final response =
          await Dio().get('http://localhost:5000/feedback_messages');
      setState(() {
        _feedbackMessages = response.data;
      });
    } catch (e) {
      throw Exception('Failed to fetch feedback messages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Сообщения'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _feedbackMessages.length,
        itemBuilder: (context, index) {
          final feedback = _feedbackMessages[index];
          final user = feedback['User'];
          final personalData = user['PersonalData'];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text('Почта: ' + '${user['Email']}'),
                subtitle: Text(feedback['Message']),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FeedbackDetailsPage(feedback: feedback),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class FeedbackDetailsPage extends StatelessWidget {
  final dynamic feedback;

  const FeedbackDetailsPage({Key? key, required this.feedback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = feedback['User'];
    final personalData = user['PersonalData'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали сообщения'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Почта: '),
                SelectableText('${user['Email']}'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectableText('${personalData['Second_name'] ?? ' '} ' +
                    '${personalData['First_name'] ?? ' '} ' +
                    '${personalData['Patronymic'] ?? ' '}'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Телефон: '),
                SelectableText('${personalData['Mobile_number'] ?? ''}'),
              ],
            ),
            SizedBox(height: 32),
            Text('Сообщение: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(feedback['Message']),
                )),
          ],
        ),
      ),
    );
  }
}
