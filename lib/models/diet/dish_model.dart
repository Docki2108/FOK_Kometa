// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'pfc_model.dart';

class DishModel {
  int id;
  String name;
  String kcal;
  PFCModel pfc;
  DishModel({
    required this.id,
    required this.name,
    required this.kcal,
    required this.pfc,
  });

  DishModel copyWith({
    int? id,
    String? name,
    String? kcal,
    PFCModel? pfc,
  }) {
    return DishModel(
      id: id ?? this.id,
      name: name ?? this.name,
      kcal: kcal ?? this.kcal,
      pfc: pfc ?? this.pfc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'kcal': kcal,
      'pfc': pfc.toMap(),
    };
  }

  factory DishModel.fromMap(Map<String, dynamic> map) {
    return DishModel(
      id: map['id_dish'] as int,
      name: map['name'] as String,
      kcal: map['kcal'].toString(),
      pfc: PFCModel.fromMap(map['pfc'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DishModel.fromJson(String source) =>
      DishModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DishModel(id: $id, name: $name, kcal: $kcal, pfc: $pfc)';
  }

  @override
  bool operator ==(covariant DishModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.kcal == kcal &&
        other.pfc == pfc;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ kcal.hashCode ^ pfc.hashCode;
  }
}
