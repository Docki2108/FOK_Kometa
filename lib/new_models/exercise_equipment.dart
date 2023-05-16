class ExerciseEquipment {
  final int id;
  final String name;
  final String description;
  final int categoryId;

  ExerciseEquipment({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
  });

  factory ExerciseEquipment.fromJson(Map<String, dynamic> json) {
    return ExerciseEquipment(
      id: json['ID_Exercise_equipment'],
      name: json['Name'],
      description: json['Description'],
      categoryId: json['Exercise_equipment_category_ID'],
    );
  }
}
