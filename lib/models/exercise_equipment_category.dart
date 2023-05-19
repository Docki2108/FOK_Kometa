import 'dart:convert';

class ExerciseEquipmentCategory {
  final int id;
  final String name;

  ExerciseEquipmentCategory({required this.id, required this.name});

  factory ExerciseEquipmentCategory.fromJson(Map<String, dynamic> json) {
    return ExerciseEquipmentCategory(
      id: json['ID_Exercise_equipment_category'],
      name: json['Name'],
    );
  }
  List<ExerciseEquipmentCategory> parseCategories(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ExerciseEquipmentCategory>(
            (json) => ExerciseEquipmentCategory.fromJson(json))
        .toList();
  }
}
