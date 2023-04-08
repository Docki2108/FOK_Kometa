// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'service_category_model.dart';

class ServiceModel {
  int id_service;
  String name;
  int cost;
  String description;
  ServiceCategoryModel service_category;
  ServiceModel({
    required this.id_service,
    required this.name,
    required this.cost,
    required this.description,
    required this.service_category,
  });

  ServiceModel copyWith({
    int? id_service,
    String? name,
    int? cost,
    String? description,
    ServiceCategoryModel? service_category,
  }) {
    return ServiceModel(
      id_service: id_service ?? this.id_service,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      description: description ?? this.description,
      service_category: service_category ?? this.service_category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_service': id_service,
      'name': name,
      'cost': cost,
      'description': description,
      'service_category': service_category.toMap(),
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id_service: map['id_service'] as int,
      name: map['name'] as String,
      cost: map['cost'] as int,
      description: map['description'] as String,
      service_category: ServiceCategoryModel.fromMap(
          map['service_category'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceModel(id_service: $id_service, name: $name, cost: $cost, description: $description, service_category: $service_category)';
  }

  @override
  bool operator ==(covariant ServiceModel other) {
    if (identical(this, other)) return true;

    return other.id_service == id_service &&
        other.name == name &&
        other.cost == cost &&
        other.description == description &&
        other.service_category == service_category;
  }

  @override
  int get hashCode {
    return id_service.hashCode ^
        name.hashCode ^
        cost.hashCode ^
        description.hashCode ^
        service_category.hashCode;
  }
}
