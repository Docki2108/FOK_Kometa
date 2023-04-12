import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../models/person_workout/person_workout_model.dart';
import '../../stuffs/constant.dart';
import '../../stuffs/graphql.dart';
import '../../stuffs/widgets.dart';

class workout_page extends StatelessWidget {
  const workout_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WorkoutPage(),
    );
  }
}

class WorkoutPage extends StatefulWidget {
  WorkoutPage({Key? key}) : super(key: key);
  HasuraConnect hasuraConnect = HasuraConnect(GRAPHQL_LINK);
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late QueryOptions currentQuery;

  List<PersonWorkoutModel> personWorkoutss = [];
  var personWorkoutUn;

  bool isLoading = true;

  @override
  void initState() {
    // GRaphQLProvider.client
    //     .query(
    //   QueryOptions(
    //     document: gql(allPersonWorkout),
    //   ),
    // )
    //     .then((value) {
    //   personWorkoutUn = value;
    //   var personWorkouts = ((personWorkoutUn.data
    //           as Map<String, dynamic>)['person_workout'] as List<dynamic>)
    //       .cast<Map<String, dynamic>>();
    //   personWorkoutss =
    //       personWorkouts.map((e) => PersonWorkoutModel.fromMap(e)).toList();

    //   setState(() {
    //     isLoading = false;
    //   });
    // });

    // currentQuery = QueryOptions(
    //   document: gql(allPersonWorkout),
    // );

    GRaphQLProvider.client
        .query(
      QueryOptions(
        document: gql(allPersonWorkout),
      ),
    )
        .then((value) {
      personWorkoutUn = value;
      var personWorkouts = ((personWorkoutUn.data
              as Map<String, dynamic>)['person_workout'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
      personWorkoutss =
          personWorkouts.map((e) => PersonWorkoutModel.fromMap(e)).toList();

      setState(() {
        isLoading = false;
      });
    });

    currentQuery = QueryOptions(
      document: gql(allPersonWorkout),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Center(
          child: Text('Тренировки'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            if (isLoading)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: personWorkoutss.length,
                  itemBuilder: (context, i) {
                    return PersonWorkoutPost(
                      id_person_workout:
                          '${personWorkoutss[i].id_person_workout}',
                      name: '${personWorkoutss[i].name}',
                      description: '${personWorkoutss[i].description}',
                      id_exercise: '${personWorkoutss[i].exercise}',
                      exercise_name: '${personWorkoutss[i].exercise}',
                      exercise_description: '${personWorkoutss[i].exercise}',
                      exercise_load_score: '${personWorkoutss[i].exercise}',
                      id_exercise_category: '${personWorkoutss[i].exercise}',
                      exercise_category_name: '${personWorkoutss[i].exercise}',
                      id_exercise_plan: '${personWorkoutss[i].exercise}',
                      exercise_plan_name: '${personWorkoutss[i].exercise}',
                      exercise_plan_description:
                          '${personWorkoutss[i].exercise}',
                      exercise_plan_number_of_repetitions:
                          '${personWorkoutss[i].exercise}',
                      exercise_plan_number_of_approaches:
                          '${personWorkoutss[i].exercise}',
                      exercise_plan_rest_time: '${personWorkoutss[i].exercise}',
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
