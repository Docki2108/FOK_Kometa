// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardModel {
  int id_card;
  String name;
  String description;
  int cost;
  CardModel({
    required this.id_card,
    required this.name,
    required this.description,
    required this.cost,
  });

  CardModel copyWith({
    int? id_card,
    String? name,
    String? description,
    int? cost,
  }) {
    return CardModel(
      id_card: id_card ?? this.id_card,
      name: name ?? this.name,
      description: description ?? this.description,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_card': id_card,
      'name': name,
      'description': description,
      'cost': cost,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id_card: map['id_card'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      cost: map['cost'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) =>
      CardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardModel(id_card: $id_card, name: $name, description: $description, cost: $cost)';
  }

  @override
  bool operator ==(covariant CardModel other) {
    if (identical(this, other)) return true;

    return other.id_card == id_card &&
        other.name == name &&
        other.description == description &&
        other.cost == cost;
  }

  @override
  int get hashCode {
    return id_card.hashCode ^
        name.hashCode ^
        description.hashCode ^
        cost.hashCode;
  }
}
