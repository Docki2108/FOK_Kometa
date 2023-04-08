import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:intl/intl.dart';

import '../models/group_workout/coach_model.dart';
import '../models/group_workout/group_workout_category_model.dart';

class NewsPost extends StatelessWidget {
  final String id_news;
  final String title;
  final String content;
  final String create_date;
  final String news_category;

  const NewsPost({
    Key? key,
    required this.id_news,
    required this.title,
    required this.content,
    required this.create_date,
    required this.news_category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Row(children: [
              Flexible(
                child: Text(
                  title,
                ),
              ),
            ]),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          title,
                        ),
                        Text(
                          news_category,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupWorkoutPost extends StatelessWidget {
  final String id_group_workout;
  final String name;
  final String description;
  final String load_score;
  final String recommended_age;
  final String event_date;
  final String start_time;
  final String end_time;
  final String group_workout_category;
  final String coach_name;
  final String coach_second_name;

  const GroupWorkoutPost({
    Key? key,
    required this.id_group_workout,
    required this.name,
    required this.description,
    required this.load_score,
    required this.recommended_age,
    required this.event_date,
    required this.start_time,
    required this.end_time,
    required this.group_workout_category,
    required this.coach_name,
    required this.coach_second_name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Card(
        elevation: 1,
        margin: EdgeInsets.all(12),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Row(children: [
                  Flexible(
                    child: Text(description),
                  ),
                ]),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Text(
                          '11:00',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                        width: 0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Text(
                          textAlign: TextAlign.left,
                          '12:00',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 7.5,
                          width: 0,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              textAlign: TextAlign.left,
                              coach_name + ' ' + coach_second_name,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                            )),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ServicePost extends StatelessWidget {
  final String id_service;
  final String name;
  final String cost;
  final String description;
  final String service_category;

  const ServicePost({
    Key? key,
    required this.id_service,
    required this.name,
    required this.cost,
    required this.description,
    required this.service_category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Row(children: [
              Flexible(
                child: Text(
                  description,
                ),
              ),
            ]),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(),
                        ),
                        Text(
                          cost,
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Widget test1() {
//   return Column(children: [
//     ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(15)),
//       child: Card(
//         elevation: 1,
//         margin: EdgeInsets.all(12),
//         child: InkWell(
//           onTap: () {},
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   flex: 0,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//                         child: Text(
//                           '11:00',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 0,
//                         width: 0,
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//                         child: Text(
//                           textAlign: TextAlign.left,
//                           '12:00',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 0,
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Total Body',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 7.5,
//                           width: 0,
//                         ),
//                         Container(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               textAlign: TextAlign.left,
//                               'И.И. Иванов',
//                               style: TextStyle(
//                                   color: Colors.grey[700], fontSize: 16),
//                             )),
//                       ]),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   ]);
// }
