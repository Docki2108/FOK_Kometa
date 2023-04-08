// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GroupWorkoutCategoryModel {
  int id_group_workout_category;
  String name;
  GroupWorkoutCategoryModel({
    required this.id_group_workout_category,
    required this.name,
  });

  GroupWorkoutCategoryModel copyWith({
    int? id_group_workout_category,
    String? name,
  }) {
    return GroupWorkoutCategoryModel(
      id_group_workout_category:
          id_group_workout_category ?? this.id_group_workout_category,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_group_workout_category': id_group_workout_category,
      'name': name,
    };
  }

  factory GroupWorkoutCategoryModel.fromMap(Map<String, dynamic> map) {
    return GroupWorkoutCategoryModel(
      id_group_workout_category: map['id_group_workout_category'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupWorkoutCategoryModel.fromJson(String source) =>
      GroupWorkoutCategoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GroupWorkoutCategoryModel(id_group_workout_category: $id_group_workout_category, name: $name)';

  @override
  bool operator ==(covariant GroupWorkoutCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id_group_workout_category == id_group_workout_category &&
        other.name == name;
  }

  @override
  int get hashCode => id_group_workout_category.hashCode ^ name.hashCode;
}
