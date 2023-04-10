// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'exercise_model.dart';

class PersonWorkoutModel {
  int id_person_workout;
  String name;
  String description;
  List<ExerciseModel> exercise;
  PersonWorkoutModel({
    required this.id_person_workout,
    required this.name,
    required this.description,
    required this.exercise,
  });

  PersonWorkoutModel copyWith({
    int? id_person_workout,
    String? name,
    String? description,
    List<ExerciseModel>? exercise,
  }) {
    return PersonWorkoutModel(
      id_person_workout: id_person_workout ?? this.id_person_workout,
      name: name ?? this.name,
      description: description ?? this.description,
      exercise: exercise ?? this.exercise,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_person_workout': id_person_workout,
      'name': name,
      'description': description,
      'exercise': exercise.map((x) => x.toMap()).toList(),
    };
  }

  factory PersonWorkoutModel.fromMap(Map<String, dynamic> map) {
    return PersonWorkoutModel(
      id_person_workout: map['id_person_workout'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      exercise: List<ExerciseModel>.from(
        (map['person_workout_exercises'] as List<dynamic>).map<ExerciseModel>(
          (x) => ExerciseModel.fromMap((x as Map<String, dynamic>)['exercise']),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonWorkoutModel.fromJson(String source) =>
      PersonWorkoutModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonWorkoutModel(id_person_workout: $id_person_workout, name: $name, description: $description, exercise: $exercise)';
  }

  @override
  bool operator ==(covariant PersonWorkoutModel other) {
    if (identical(this, other)) return true;

    return other.id_person_workout == id_person_workout &&
        other.name == name &&
        other.description == description &&
        listEquals(other.exercise, exercise);
  }

  @override
  int get hashCode {
    return id_person_workout.hashCode ^
        name.hashCode ^
        description.hashCode ^
        exercise.hashCode;
  }
}
