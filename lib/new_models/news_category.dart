class NewsCategory {
  int id;
  String name;

  NewsCategory({required this.id, required this.name});

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}
