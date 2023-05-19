class GroupWorkoutCategory {
  final int id;
  final String name;

  GroupWorkoutCategory({required this.id, required this.name});

  factory GroupWorkoutCategory.fromJson(Map<String, dynamic> json) {
    return GroupWorkoutCategory(
      id: json['ID_Group_workout_category'],
      name: json['Name'],
    );
  }
}
