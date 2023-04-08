// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CoachModel {
  int id_coach;
  String coachs_second_name;
  String coachs_first_name;
  String coachs_patronymic;
  String specialization;
  int work_experience;
  String sporting_achievements;
  CoachModel({
    required this.id_coach,
    required this.coachs_second_name,
    required this.coachs_first_name,
    required this.coachs_patronymic,
    required this.specialization,
    required this.work_experience,
    required this.sporting_achievements,
  });

  CoachModel copyWith({
    int? id_coach,
    String? coachs_second_name,
    String? coachs_first_name,
    String? coachs_patronymic,
    String? specialization,
    int? work_experience,
    String? sporting_achievements,
  }) {
    return CoachModel(
      id_coach: id_coach ?? this.id_coach,
      coachs_second_name: coachs_second_name ?? this.coachs_second_name,
      coachs_first_name: coachs_first_name ?? this.coachs_first_name,
      coachs_patronymic: coachs_patronymic ?? this.coachs_patronymic,
      specialization: specialization ?? this.specialization,
      work_experience: work_experience ?? this.work_experience,
      sporting_achievements:
          sporting_achievements ?? this.sporting_achievements,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_coach': id_coach,
      'coachs_second_name': coachs_second_name,
      'coachs_first_name': coachs_first_name,
      'coachs_patronymic': coachs_patronymic,
      'specialization': specialization,
      'work_experience': work_experience,
      'sporting_achievements': sporting_achievements,
    };
  }

  factory CoachModel.fromMap(Map<String, dynamic> map) {
    return CoachModel(
      id_coach: map['id_coach'] as int,
      coachs_second_name: map['coachs_second_name'] as String,
      coachs_first_name: map['coachs_first_name'] as String,
      coachs_patronymic: map['coachs_patronymic'] as String,
      specialization: map['specialization'] as String,
      work_experience: map['work_experience'] as int,
      sporting_achievements: map['sporting_achievements'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoachModel.fromJson(String source) =>
      CoachModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CoachModel(id_coach: $id_coach, coachs_second_name: $coachs_second_name, coachs_first_name: $coachs_first_name, coachs_patronymic: $coachs_patronymic, specialization: $specialization, work_experience: $work_experience, sporting_achievements: $sporting_achievements)';
  }

  @override
  bool operator ==(covariant CoachModel other) {
    if (identical(this, other)) return true;

    return other.id_coach == id_coach &&
        other.coachs_second_name == coachs_second_name &&
        other.coachs_first_name == coachs_first_name &&
        other.coachs_patronymic == coachs_patronymic &&
        other.specialization == specialization &&
        other.work_experience == work_experience &&
        other.sporting_achievements == sporting_achievements;
  }

  @override
  int get hashCode {
    return id_coach.hashCode ^
        coachs_second_name.hashCode ^
        coachs_first_name.hashCode ^
        coachs_patronymic.hashCode ^
        specialization.hashCode ^
        work_experience.hashCode ^
        sporting_achievements.hashCode;
  }
}
