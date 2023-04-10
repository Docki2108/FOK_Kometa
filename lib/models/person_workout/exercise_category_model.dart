// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExerciseCategoryModel {
  int id_exercise_category;
  String name;
  ExerciseCategoryModel({
    required this.id_exercise_category,
    required this.name,
  });

  ExerciseCategoryModel copyWith({
    int? id_exercise_category,
    String? name,
  }) {
    return ExerciseCategoryModel(
      id_exercise_category: id_exercise_category ?? this.id_exercise_category,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_exercise_category': id_exercise_category,
      'name': name,
    };
  }

  factory ExerciseCategoryModel.fromMap(Map<String, dynamic> map) {
    return ExerciseCategoryModel(
      id_exercise_category: map['id_exercise_category'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseCategoryModel.fromJson(String source) =>
      ExerciseCategoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ExerciseCategoryModel(id_exercise_category: $id_exercise_category, name: $name)';

  @override
  bool operator ==(covariant ExerciseCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id_exercise_category == id_exercise_category &&
        other.name == name;
  }

  @override
  int get hashCode => id_exercise_category.hashCode ^ name.hashCode;
}
