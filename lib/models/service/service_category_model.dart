// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServiceCategoryModel {
  int id;
  String name;
  ServiceCategoryModel({
    required this.id,
    required this.name,
  });

  ServiceCategoryModel copyWith({
    int? id,
    String? name,
  }) {
    return ServiceCategoryModel(
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

  factory ServiceCategoryModel.fromMap(Map<String, dynamic> map) {
    return ServiceCategoryModel(
      id: map['id_service_category'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceCategoryModel.fromJson(String source) =>
      ServiceCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ServiceCategoryModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant ServiceCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
