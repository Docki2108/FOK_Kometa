// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class exercise_equipment_page extends StatelessWidget {
//   exercise_equipment_page({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ExerciseEquipmentPage(),
//     );
//   }
// }

// class ExerciseEquipmentPage extends StatefulWidget {
//   ExerciseEquipmentPage({Key? key}) : super(key: key);
//   @override
//   State<ExerciseEquipmentPage> createState() => _ExerciseEquipmentPageState();
// }

// class _ExerciseEquipmentPageState extends State<ExerciseEquipmentPage> {
//   List<dynamic> _feedbackMessages = [];

//   @override
//   void initState() {
//     super.initState();

//     _loadFeedbackMessages();
//   }

//   Future<void> _loadFeedbackMessages() async {
//     try {
//       var response = await Dio().get('http://10.0.2.2:5000/feedback_messages');
//       setState(() {
//         _feedbackMessages = response.data;
//       });
//     } catch (error) {
//       print('Error: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 3,
//         title: const Text('Тренажеры'),
//         actions: [],
//       ),
//       body: ListView.builder(
//         itemCount: _feedbackMessages.length,
//         itemBuilder: (BuildContext context, int index) {
//           var feedbackMessage = _feedbackMessages[index];
//           return ListTile(
//             title: Text(feedbackMessage['Message']),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                     'ФИО: ${feedbackMessage['User']['PersonalData']['First_name']} ${feedbackMessage['User']['PersonalData']['Second_name']}'),
//                 Text('Почта: ${feedbackMessage['User']['Email']}'),
//                 Text(
//                     'Телефон: ${feedbackMessage['User']['PersonalData']['Mobile_number']}'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
