// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'coach_model.dart';
import 'group_workout_category_model.dart';

class GroupWorkoutModel {
  int id;
  String name;
  String description;
  String load_score;
  String recommended_age;
  DateTime event_date;
  TimeOfDay start_time;
  TimeOfDay end_time;
  GroupWorkoutCategoryModel group_workout_category;
  CoachModel coach;
  GroupWorkoutModel({
    required this.id,
    required this.name,
    required this.description,
    required this.load_score,
    required this.recommended_age,
    required this.event_date,
    required this.start_time,
    required this.end_time,
    required this.group_workout_category,
    required this.coach,
  });

  GroupWorkoutModel copyWith({
    int? id,
    String? name,
    String? description,
    String? load_score,
    String? recommended_age,
    DateTime? event_date,
    TimeOfDay? start_time,
    TimeOfDay? end_time,
    GroupWorkoutCategoryModel? group_workout_category,
    CoachModel? coach,
  }) {
    return GroupWorkoutModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      load_score: load_score ?? this.load_score,
      recommended_age: recommended_age ?? this.recommended_age,
      event_date: event_date ?? this.event_date,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
      group_workout_category:
          group_workout_category ?? this.group_workout_category,
      coach: coach ?? this.coach,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'load_score': load_score,
      'recommended_age': recommended_age,
      'event_date': event_date.millisecondsSinceEpoch,
      'start_time': start_time..toString(),
      'end_time': end_time..toString(),
      'group_workout_category': group_workout_category.toMap(),
      'coach': coach.toMap(),
    };
  }

  factory GroupWorkoutModel.fromMap(Map<String, dynamic> map) {
    var unParsedStart_time = map['start_time'] as String;
    var unParsedEnd_time = map['end_time'] as String;

    return GroupWorkoutModel(
      id: map['id_group_workout'] as int,
      name: map['name'] as String,
      description: map['description'].toString(),
      load_score: map['load_score'].toString(),
      recommended_age: map['recommended_age'].toString(),
      event_date: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      start_time: TimeOfDay(
          hour: int.parse(unParsedStart_time.split(":")[0]),
          minute: int.parse(unParsedStart_time.split(":")[1])),
      end_time: TimeOfDay(
          hour: int.parse(unParsedEnd_time.split(":")[0]),
          minute: int.parse(unParsedEnd_time.split(":")[1])),
      group_workout_category: GroupWorkoutCategoryModel.fromMap(
          map['group_workout_category'] as Map<String, dynamic>),
      coach: CoachModel.fromMap(map['coach'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupWorkoutModel.fromJson(String source) =>
      GroupWorkoutModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupWorkoutModel(id: $id, name: $name, description: $description, load_score: $load_score, recommended_age: $recommended_age, event_date: $event_date, start_time: $start_time, end_time: $end_time, group_workout_category: $group_workout_category, coach: $coach)';
  }

  @override
  bool operator ==(covariant GroupWorkoutModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.load_score == load_score &&
        other.recommended_age == recommended_age &&
        other.event_date == event_date &&
        other.start_time == start_time &&
        other.end_time == end_time &&
        other.group_workout_category == group_workout_category &&
        other.coach == coach;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        load_score.hashCode ^
        recommended_age.hashCode ^
        event_date.hashCode ^
        start_time.hashCode ^
        end_time.hashCode ^
        group_workout_category.hashCode ^
        coach.hashCode;
  }
}
