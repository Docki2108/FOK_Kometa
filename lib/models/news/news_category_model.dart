// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewsCategoryModel {
  int id;
  String name;
  NewsCategoryModel({
    required this.id,
    required this.name,
  });

  NewsCategoryModel copyWith({
    int? id,
    String? name,
  }) {
    return NewsCategoryModel(
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

  factory NewsCategoryModel.fromMap(Map<String, dynamic> map) {
    return NewsCategoryModel(
      id: map['id_news_category'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsCategoryModel.fromJson(String source) =>
      NewsCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NewsCategoryModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant NewsCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
