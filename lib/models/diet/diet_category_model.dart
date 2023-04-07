// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DietCategoryModel {
  int id;
  String name;
  DietCategoryModel({
    required this.id,
    required this.name,
  });

  DietCategoryModel copyWith({
    int? id,
    String? name,
  }) {
    return DietCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory DietCategoryModel.fromMap(Map<String, dynamic> map) {
    return DietCategoryModel(
      id: map['id_diet_category'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DietCategoryModel.fromJson(String source) =>
      DietCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DietCategoryModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant DietCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
