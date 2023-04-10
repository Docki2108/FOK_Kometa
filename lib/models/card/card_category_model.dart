// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardCategoryModel {
  int id_card_category;
  String name;
  int number_of_visits;
  DateTime start_date;
  DateTime end_date;
  CardCategoryModel({
    required this.id_card_category,
    required this.name,
    required this.number_of_visits,
    required this.start_date,
    required this.end_date,
  });

  CardCategoryModel copyWith({
    int? id_card_category,
    String? name,
    int? number_of_visits,
    DateTime? start_date,
    DateTime? end_date,
  }) {
    return CardCategoryModel(
      id_card_category: id_card_category ?? this.id_card_category,
      name: name ?? this.name,
      number_of_visits: number_of_visits ?? this.number_of_visits,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_card_category': id_card_category,
      'name': name,
      'number_of_visits': number_of_visits,
      'start_date': start_date.millisecondsSinceEpoch,
      'end_date': end_date.millisecondsSinceEpoch,
    };
  }

  factory CardCategoryModel.fromMap(Map<String, dynamic> map) {
    return CardCategoryModel(
      id_card_category: map['id_card_category'] as int,
      name: map['name'] as String,
      number_of_visits: map['number_of_visits'] as int,
      start_date: DateTime.fromMillisecondsSinceEpoch(map['start_date'] as int),
      end_date: DateTime.fromMillisecondsSinceEpoch(map['end_date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardCategoryModel.fromJson(String source) =>
      CardCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardCategoryModel(id_card_category: $id_card_category, name: $name, number_of_visits: $number_of_visits, start_date: $start_date, end_date: $end_date)';
  }

  @override
  bool operator ==(covariant CardCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id_card_category == id_card_category &&
        other.name == name &&
        other.number_of_visits == number_of_visits &&
        other.start_date == start_date &&
        other.end_date == end_date;
  }

  @override
  int get hashCode {
    return id_card_category.hashCode ^
        name.hashCode ^
        number_of_visits.hashCode ^
        start_date.hashCode ^
        end_date.hashCode;
  }
}
