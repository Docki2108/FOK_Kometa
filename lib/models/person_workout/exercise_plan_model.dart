// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExercisePlanModel {
  int id_exercise_plan;
  String name;
  String description;
  ExercisePlanModel({
    required this.id_exercise_plan,
    required this.name,
    required this.description,
  });

  ExercisePlanModel copyWith({
    int? id_exercise_plan,
    String? name,
    String? description,
  }) {
    return ExercisePlanModel(
      id_exercise_plan: id_exercise_plan ?? this.id_exercise_plan,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_exercise_plan': id_exercise_plan,
      'name': name,
      'description': description,
    };
  }

  factory ExercisePlanModel.fromMap(Map<String, dynamic> map) {
    return ExercisePlanModel(
      id_exercise_plan: map['id_exercise_plan'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExercisePlanModel.fromJson(String source) =>
      ExercisePlanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ExercisePlanModel(id_exercise_plan: $id_exercise_plan, name: $name, description: $description)';

  @override
  bool operator ==(covariant ExercisePlanModel other) {
    if (identical(this, other)) return true;

    return other.id_exercise_plan == id_exercise_plan &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode =>
      id_exercise_plan.hashCode ^ name.hashCode ^ description.hashCode;
}
