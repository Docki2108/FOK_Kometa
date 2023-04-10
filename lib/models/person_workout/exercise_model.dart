// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'exercise_category_model.dart';
import 'exercise_plan_model.dart';

class ExerciseModel {
  int id_exercise;
  String name;
  String description;
  int load_score;
  List<ExerciseCategoryModel> exercise_category;
  List<ExercisePlanModel> exercise_plan;
  ExerciseModel({
    required this.id_exercise,
    required this.name,
    required this.description,
    required this.load_score,
    required this.exercise_category,
    required this.exercise_plan,
  });

  ExerciseModel copyWith({
    int? id_exercise,
    String? name,
    String? description,
    int? load_score,
    List<ExerciseCategoryModel>? exercise_category,
    List<ExercisePlanModel>? exercise_plan,
  }) {
    return ExerciseModel(
      id_exercise: id_exercise ?? this.id_exercise,
      name: name ?? this.name,
      description: description ?? this.description,
      load_score: load_score ?? this.load_score,
      exercise_category: exercise_category ?? this.exercise_category,
      exercise_plan: exercise_plan ?? this.exercise_plan,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_exercise': id_exercise,
      'name': name,
      'description': description,
      'load_score': load_score,
      'exercise_category': exercise_category.map((x) => x.toMap()).toList(),
      'exercise_plan': exercise_plan.map((x) => x.toMap()).toList(),
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id_exercise: map['id_exercise'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      load_score: map['load_score'] as int,
      exercise_category: List<ExerciseCategoryModel>.from(
        (map['exercise_category'] as List<dynamic>).map<ExerciseCategoryModel>(
          (x) => ExerciseCategoryModel.fromMap(
              (x as Map<String, dynamic>)['exercise_category']),
        ),
      ),
      exercise_plan: List<ExercisePlanModel>.from(
        (map['exercise_plan'] as List<dynamic>).map<ExercisePlanModel>(
          (x) => ExercisePlanModel.fromMap(
              (x as Map<String, dynamic>)['exercise_plan']),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseModel.fromJson(String source) =>
      ExerciseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExerciseModel(id_exercise: $id_exercise, name: $name, description: $description, load_score: $load_score, exercise_category: $exercise_category, exercise_plan: $exercise_plan)';
  }

  @override
  bool operator ==(covariant ExerciseModel other) {
    if (identical(this, other)) return true;

    return other.id_exercise == id_exercise &&
        other.name == name &&
        other.description == description &&
        other.load_score == load_score &&
        other.exercise_category == exercise_category &&
        other.exercise_plan == exercise_plan;
  }

  @override
  int get hashCode {
    return id_exercise.hashCode ^
        name.hashCode ^
        description.hashCode ^
        load_score.hashCode ^
        exercise_category.hashCode ^
        exercise_plan.hashCode;
  }
}
