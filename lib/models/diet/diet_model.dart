// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'diet_category_model.dart';
import 'eating_model.dart';

class DietModel {
  int id;
  String name;
  int duration;
  DietCategoryModel diet_category;
  List<EatingModel> eating;
  DietModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.diet_category,
    required this.eating,
  });

  DietModel copyWith({
    int? id,
    String? name,
    int? duration,
    DietCategoryModel? diet_category,
    List<EatingModel>? eating,
  }) {
    return DietModel(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      diet_category: diet_category ?? this.diet_category,
      eating: eating ?? this.eating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'duration': duration,
      'diet_category': diet_category.toMap(),
      'eating': eating.map((x) => x.toMap()).toList(),
    };
  }

  factory DietModel.fromMap(Map<String, dynamic> map) {
    return DietModel(
      id: map['id_diet'] as int,
      name: map['name'] as String,
      duration: map['duration'] as int,
      diet_category: DietCategoryModel.fromMap(
          map['diet_category'] as Map<String, dynamic>),
      eating: List<EatingModel>.from(
        (map['diet_eatings'] as List<dynamic>).map<EatingModel>(
          (x) => EatingModel.fromMap((x as Map<String, dynamic>)['eating']),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DietModel.fromJson(String source) =>
      DietModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DietModel(id: $id, name: $name, duration: $duration, diet_category: $diet_category, eating: $eating)';
  }

  @override
  bool operator ==(covariant DietModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.duration == duration &&
        other.diet_category == diet_category &&
        listEquals(other.eating, eating);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        duration.hashCode ^
        diet_category.hashCode ^
        eating.hashCode;
  }
}
