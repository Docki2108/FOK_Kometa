class DietCategory {
  int id;
  String name;

  DietCategory({required this.id, required this.name});

  factory DietCategory.fromJson(Map<String, dynamic> json) {
    return DietCategory(
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
