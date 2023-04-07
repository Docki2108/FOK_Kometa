// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'news_category_model.dart';

class NewsModel {
  int id;
  String title;
  String content;
  DateTime create_date;
  NewsCategoryModel news_category;
  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.create_date,
    required this.news_category,
  });

  NewsModel copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? create_date,
    NewsCategoryModel? news_category,
  }) {
    return NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      create_date: create_date ?? this.create_date,
      news_category: news_category ?? this.news_category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'create_date': create_date.millisecondsSinceEpoch,
      'news_category': news_category.toMap(),
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id_news'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      create_date: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      news_category: NewsCategoryModel.fromMap(
          map['news_category'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, content: $content, create_date: $create_date, news_category: $news_category)';
  }

  @override
  bool operator ==(covariant NewsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.create_date == create_date &&
        other.news_category == news_category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        create_date.hashCode ^
        news_category.hashCode;
  }
}
