class Diet {
  final int id;
  final String name;
  final int duration;
  final int dietCategoryId;

  Diet(
      {required this.id,
      required this.name,
      required this.duration,
      required this.dietCategoryId});

  factory Diet.fromJson(Map<String, dynamic> json) {
    return Diet(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      dietCategoryId: json['diet_category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'diet_category_id': dietCategoryId,
    };
  }
}
