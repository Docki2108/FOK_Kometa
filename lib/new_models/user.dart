import 'personal_data.dart';

class User {
  static User? _context;
  final int id;
  final String email;
  final String role;
  final PersonalData personalData;

  User._(
      {required this.id,
      required this.email,
      required this.role,
      required this.personalData});

  factory User.get() {
    if (_context == null) {
      throw UnimplementedError(
          "Мы не сделали конструктор для юзера нормально. Используй User.fromJson");
    } else {
      return _context!;
    }
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return _context = User._(
      id: json['id_user'],
      email: json['email'],
      role: json['role'],
      personalData: PersonalData.fromJson(json['personal_data']),
    );
  }
}
