// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fok_kometa/models/diet/dish_model.dart';

class EatingModel {
  int id;
  String name;
  TimeOfDay eating_time;
  List<DishModel> dish;
  EatingModel({
    required this.id,
    required this.name,
    required this.eating_time,
    required this.dish,
  });

  EatingModel copyWith({
    int? id,
    String? name,
    TimeOfDay? eating_time,
    List<DishModel>? dish,
  }) {
    return EatingModel(
      id: id ?? this.id,
      name: name ?? this.name,
      eating_time: eating_time ?? this.eating_time,
      dish: dish ?? this.dish,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'eating_time': eating_time..toString(),
      'dish': dish.map((x) => x.toMap()).toList(),
    };
  }

  factory EatingModel.fromMap(Map<String, dynamic> map) {
    var unParsedEatingTime = map['eating_time'] as String;
    return EatingModel(
      id: map['id_eating'] as int,
      name: map['name'] as String,
      eating_time: TimeOfDay(
          hour: int.parse(unParsedEatingTime.split(":")[0]),
          minute: int.parse(unParsedEatingTime.split(":")[1])),
      dish: List<DishModel>.from(
        (map['eating_dishes'] as List<dynamic>).map<DishModel>(
          (x) => DishModel.fromMap((x as Map<String, dynamic>)['dish']),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EatingModel.fromJson(String source) =>
      EatingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EatingModel(id: $id, name: $name, eating_time: $eating_time, dish: $dish)';
  }

  @override
  bool operator ==(covariant EatingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.eating_time == eating_time &&
        listEquals(other.dish, dish);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ eating_time.hashCode ^ dish.hashCode;
  }
}
