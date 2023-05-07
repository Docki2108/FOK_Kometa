class ServiceCategory {
  int id;
  String name;

  ServiceCategory({required this.id, required this.name});

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}
