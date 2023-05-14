class DishCategory {
  int id;
  String name;

  DishCategory({required this.id, required this.name});

  factory DishCategory.fromJson(Map<String, dynamic> json) {
    return DishCategory(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
