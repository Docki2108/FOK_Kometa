class Dish {
  int id;
  String name;
  int kcal;
  String pfc;
  String diet;
  String category;

  Dish(
      {required this.id,
      required this.name,
      required this.kcal,
      required this.pfc,
      required this.diet,
      required this.category});

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      kcal: json['kcal'],
      pfc: json['pfc'],
      diet: json['diet'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'kcal': kcal,
      'pfc': pfc,
      'diet': diet,
      'category': category,
    };
  }
}
