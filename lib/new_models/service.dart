class Service {
  int id;
  String name;
  int cost;
  String description;
  int user_id;
  int category_id;

  Service(
      {required this.id,
      required this.name,
      required this.cost,
      required this.description,
      required this.user_id,
      required this.category_id});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      cost: json['cost'],
      description: json['description'],
      user_id: json['user_id'],
      category_id: json['category_id'],
    );
  }
}
