import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:intl/intl.dart';

import '../../../models/group_workout/group_workout_model.dart';
import '../../../stuffs/constant.dart';
import '../../../stuffs/graphql.dart';
import '../../../stuffs/widgets.dart';

class schedule_page extends StatelessWidget {
  const schedule_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _controller = PageController();
  String textdate = '';
  List<GroupWorkoutModel> groupWorkouts = [];
  var groupWorkoutsUn;
  late QueryOptions currentQuery;

  @override
  void initState() {
    textdate = DateFormat('M.y').format(todaydate);

    GRaphQLProvider.client
        .query(
      QueryOptions(
        document: gql(allGroupWorkout),
      ),
    )
        .then((value) {
      groupWorkoutsUn = value;
      var groupWorkoutList = ((groupWorkoutsUn.data
              as Map<String, dynamic>)['group_workout'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
      groupWorkouts =
          groupWorkoutList.map((e) => GroupWorkoutModel.fromMap(e)).toList();

      setState(() {
        isLoading = false;
      });
    });

    currentQuery = QueryOptions(
      document: gql(allGroupWorkout),
    );
    super.initState();
  }

  var todaydate = DateTime.now();
  var tomorrowdate = DateTime.now().add(new Duration(days: 1));
  var aftertomorrowdate = DateTime.now().add(new Duration(days: 2));
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          //Card(
          // margin: EdgeInsets.all(10),
          // elevation: 1,
          //child:
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              size: 22,
            ),
            tooltip: 'Информация',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Описание групповых занятий'),
                  content: SingleChildScrollView(
                    child: const Text(
                      DESCRIPTION_OF_GROUP_TRAINING,
                    ),
                  ),
                  actions: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: const Text(
                        'Ок',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          //),
        ],
        elevation: 3,
        centerTitle: true,
        title: Text('Расписание на ' + textdate),
        //Text(textdate),
      ),
      body: Center(
        child: Column(
          children: [
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: ListView.builder(
                  itemCount: groupWorkouts.length,
                  itemBuilder: (context, i) {
                    return GroupWorkoutPost(
                        id_group_workout: '${groupWorkouts[i].id}',
                        name: '${groupWorkouts[i].name}',
                        description: '${groupWorkouts[i].description}',
                        load_score: '${groupWorkouts[i].load_score}',
                        event_date: '${groupWorkouts[i].event_date}',
                        recommended_age: '${groupWorkouts[i].recommended_age}',
                        start_time: '${groupWorkouts[i].start_time}',
                        end_time: '${groupWorkouts[i].end_time}',
                        group_workout_category:
                            '${groupWorkouts[i].group_workout_category}',
                        coach_name:
                            '${groupWorkouts[i].coach.coachs_first_name}',
                        coach_second_name:
                            '${groupWorkouts[i].coach.coachs_second_name}',
                        coach_patronymic:
                            '${groupWorkouts[i].coach.coachs_patronymic}');
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget dotsview() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: ConstrainedBox(
  //       constraints: BoxConstraints(
  //         minWidth: 150,
  //         minHeight: 150,
  //         maxWidth: MediaQuery.of(context).size.width,
  //         maxHeight: MediaQuery.of(context).size.height * 0.815,
  //       ),
  //       child: PageView(
  //         controller: _controller,
  //         children: const [TodayPage(), TomorrowPage(), DayAfterPage()],
  //       ),
  //     ),
  //   );
  // }

  // Widget get dots {
  //   return ConstrainedBox(
  //     constraints: BoxConstraints(
  //         minWidth: 40, maxWidth: 100, minHeight: 20, maxHeight: 20),
  //     child: Container(
  //       padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: SmoothPageIndicator(
  //         controller: _controller,
  //         count: 3,
  //         effect: SwapEffect(
  //             activeDotColor: Colors.black,
  //             dotHeight: 10,
  //             dotWidth: 10,
  //             spacing: 10),
  //       ),
  //     ),
  //   );
  // }
}
