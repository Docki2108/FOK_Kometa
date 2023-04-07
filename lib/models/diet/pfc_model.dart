// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PFCModel {
  int id;
  String proteins;
  String fats;
  String carbohydrates;
  PFCModel({
    required this.id,
    required this.proteins,
    required this.fats,
    required this.carbohydrates,
  });

  PFCModel copyWith({
    int? id,
    String? proteins,
    String? fats,
    String? carbohydrates,
  }) {
    return PFCModel(
      id: id ?? this.id,
      proteins: proteins ?? this.proteins,
      fats: fats ?? this.fats,
      carbohydrates: carbohydrates ?? this.carbohydrates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'proteins': proteins,
      'fats': fats,
      'carbohydrates': carbohydrates,
    };
  }

  factory PFCModel.fromMap(Map<String, dynamic> map) {
    return PFCModel(
      id: map['id_pfc'] as int,
      proteins: map['proteins'].toString(),
      fats: map['fats'].toString(),
      carbohydrates: map['carbohydrates'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PFCModel.fromJson(String source) =>
      PFCModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PFCModel(id: $id, proteins: $proteins, fats: $fats, carbohydrates: $carbohydrates)';
  }

  @override
  bool operator ==(covariant PFCModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.proteins == proteins &&
        other.fats == fats &&
        other.carbohydrates == carbohydrates;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        proteins.hashCode ^
        fats.hashCode ^
        carbohydrates.hashCode;
  }
}
