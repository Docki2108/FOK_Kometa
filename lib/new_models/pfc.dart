class PFC {
  int id;
  int proteins;
  int fats;
  int carbohydrates;

  PFC(
      {required this.id,
      required this.proteins,
      required this.fats,
      required this.carbohydrates});

  factory PFC.fromJson(Map<String, dynamic> json) {
    return PFC(
      id: json['id'],
      proteins: json['proteins'],
      fats: json['fats'],
      carbohydrates: json['carbohydrates'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'proteins': proteins,
      'fats': fats,
      'carbohydrates': carbohydrates,
    };
  }
}
