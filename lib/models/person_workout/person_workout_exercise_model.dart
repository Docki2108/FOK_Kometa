// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'exercise_model.dart';
import 'person_workout_model.dart';

class PersonWorkoutExerciseModel {
  ExerciseModel exercise;
  PersonWorkoutModel person_workout;
  PersonWorkoutExerciseModel({
    required this.exercise,
    required this.person_workout,
  });

  PersonWorkoutExerciseModel copyWith({
    ExerciseModel? exercise,
    PersonWorkoutModel? person_workout,
  }) {
    return PersonWorkoutExerciseModel(
      exercise: exercise ?? this.exercise,
      person_workout: person_workout ?? this.person_workout,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exercise': exercise.toMap(),
      'person_workout': person_workout.toMap(),
    };
  }

  factory PersonWorkoutExerciseModel.fromMap(Map<String, dynamic> map) {
    return PersonWorkoutExerciseModel(
      exercise: ExerciseModel.fromMap(map['exercise'] as Map<String, dynamic>),
      person_workout: PersonWorkoutModel.fromMap(
          map['person_workout'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonWorkoutExerciseModel.fromJson(String source) =>
      PersonWorkoutExerciseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PersonWorkoutExerciseModel(exercise: $exercise, person_workout: $person_workout)';

  @override
  bool operator ==(covariant PersonWorkoutExerciseModel other) {
    if (identical(this, other)) return true;

    return other.exercise == exercise && other.person_workout == person_workout;
  }

  @override
  int get hashCode => exercise.hashCode ^ person_workout.hashCode;
}
