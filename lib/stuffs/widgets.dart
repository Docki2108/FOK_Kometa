import 'package:flutter/material.dart';
import 'package:fok_kometa/models/person_workout/person_workout_model.dart';
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
  final String coach_patronymic;

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
    required this.coach_patronymic,
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
                content: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 220,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(description),
                          Text(''),
                          Row(
                            children: [
                              Text('Рекомендуемый возраст: $recommended_age')
                            ],
                          ),
                          Text(''),
                          Row(
                            children: [Text('Нагрузка: $load_score')],
                          ),
                          Text(''),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    'Тренер: $coach_second_name $coach_name $coach_patronymic'),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
                    ],
                  ),
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
    return Card(
      child: ExpansionTile(
        title: Text(name),
        subtitle: Text(cost + ' руб.'),
        children: [
          ListTile(
            // leading: CircleAvatar(
            //   child: Text(''),
            //   backgroundColor: Colors.white,
            // ),
            title: Text(description),
          ),
        ],
      ),
    );
  }
}

class PersonWorkoutPost extends StatelessWidget {
  //final PersonWorkoutModel personWorkout;
  final String id_person_workout;
  final String name;
  final String description;
  final String id_exercise;
  final String exercise_name;
  final String exercise_description;
  final String exercise_load_score;
  final String id_exercise_category;
  final String exercise_category_name;
  final String id_exercise_plan;
  final String exercise_plan_name;
  final String exercise_plan_description;
  final String exercise_plan_number_of_repetitions;
  final String exercise_plan_number_of_approaches;
  final String exercise_plan_rest_time;

  const PersonWorkoutPost({
    Key? key,
    //required this.personWorkout,
    required this.id_person_workout,
    required this.name,
    required this.description,
    required this.id_exercise,
    required this.exercise_name,
    required this.exercise_description,
    required this.exercise_load_score,
    required this.id_exercise_category,
    required this.exercise_category_name,
    required this.id_exercise_plan,
    required this.exercise_plan_name,
    required this.exercise_plan_description,
    required this.exercise_plan_number_of_repetitions,
    required this.exercise_plan_number_of_approaches,
    required this.exercise_plan_rest_time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(name),
        subtitle: Text(description),
        children: [
          ListTile(
            title: Text(exercise_description
                //personWorkout.name
                ),
          ),
          ListTile(
            title: Text(exercise_description),
          ),
        ],
      ),
    );
  }
}

class DietPost extends StatelessWidget {
  final String id_diet;
  final String name;
  final String duration;

  const DietPost({
    Key? key,
    required this.id_diet,
    required this.name,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   showDialog(
      //     context: context,
      //     builder: (_) => AlertDialog(
      //       content: Row(children: [
      //         Flexible(
      //           child: Text(
      //             title,
      //           ),
      //         ),
      //       ]),
      //     ),
      //   );
      // },
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
                        ),
                        Text(
                          'Количество дней диеты: ' + duration,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
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

Widget test1() {
  return Column(children: [
    ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Card(
        elevation: 1,
        margin: EdgeInsets.all(12),
        child: InkWell(
          onTap: () {},
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
                            'Total Body',
                            style: TextStyle(fontSize: 20),
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
                              'И.И. Иванов',
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
    ),
  ]);
}
