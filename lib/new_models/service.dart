class Service {
  final int id;
  final String name;
  final int cost;
  final String description;
  final int userId;
  final String category;

  Service({
    required this.id,
    required this.name,
    required this.cost,
    required this.description,
    required this.userId,
    required this.category,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      cost: json['cost'],
      description: json['description'],
      userId: json['user_id'],
      category: json['service_category'],
    );
  }
}
