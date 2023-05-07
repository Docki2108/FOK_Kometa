class News {
  int id;
  String title;
  String content;
  int categoryId;
  String createDate;

  News(
      {required this.id,
      required this.title,
      required this.content,
      required this.categoryId,
      required this.createDate});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      categoryId: json['category_id'],
      createDate: json['create_date'],
    );
  }
}
